package com.iisigroup.sqldeploy;

import org.apache.maven.plugin.testing.AbstractMojoTestCase;
import org.apache.maven.plugin.testing.MojoRule;
import org.apache.maven.plugin.testing.WithoutMojo;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import static org.junit.Assert.*;

public class SqlGenMojoTest {

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
//    @Test
    public void testSomething() throws Exception {
        File pom = new File( "target/test-classes/project-to-test/" );
        assertNotNull( pom );
        assertTrue( pom.exists() );

        SqlGenMojo myMojo = (SqlGenMojo) rule.lookupConfiguredMojo( pom,"gen-sql");
        assertNotNull( myMojo );
        myMojo.execute();

        File deployFolder = (File) rule.getVariableValueFromObject(myMojo, "deployFolder");
        System.out.println(deployFolder.getAbsolutePath());
        assertNotNull(deployFolder);
        assertTrue(deployFolder.exists());

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String todayStr = dateFormat.format(new Date());
        File touch = new File(deployFolder, "DeployUAT"+todayStr+".sql");
        assertTrue("deploy file not exist", touch.exists());

    }

    /**
     * Do not need the MojoRule.
     */
//    @WithoutMojo
//    @Test
    public void testSomethingWhichDoesNotNeedTheMojoAndProbablyShouldBeExtractedIntoANewClassOfItsOwn() {
        assertTrue(true);
    }
}