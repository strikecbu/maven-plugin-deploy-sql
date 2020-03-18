package com.iisigroup.sqldeploy;

import org.apache.maven.plugin.testing.MojoRule;
import org.apache.maven.plugin.testing.WithoutMojo;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

public class ProdSqlGenMojoTest {

    @Rule
    public MojoRule rule = new MojoRule()
    {
        @Override
        protected void before() throws Throwable
        {
        }

        @Override
        protected void after()
        {
        }
    };

    @Before
    public void setUp() throws Exception {
    }

    /**
     * @throws Exception if any
     */
    @Test
    public void testSomething() throws Exception {
        File pom = new File( "target/test-classes/project-to-test/genProd" );
        assertNotNull( pom );
        assertTrue( pom.exists() );

        ProdSqlGenMojo myMojo = (ProdSqlGenMojo) rule.lookupConfiguredMojo( pom,"gen-prod-sql");
        assertNotNull( myMojo );
        myMojo.execute();

        File deployFolder = (File) rule.getVariableValueFromObject(myMojo, "deployProdFolder");
        System.out.println(deployFolder.getAbsolutePath());
        assertNotNull(deployFolder);
        assertTrue(deployFolder.exists());

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String todayStr = dateFormat.format(new Date());
        File touch = new File(deployFolder, "DeployPROD"+todayStr+".sql");
        assertTrue("deploy file not exist", touch.exists());

    }

    /**
     * Do not need the MojoRule.
     */
    @WithoutMojo
    @Test
    public void testSomethingWhichDoesNotNeedTheMojoAndProbablyShouldBeExtractedIntoANewClassOfItsOwn() {
        assertTrue(true);
    }
}