package com.iisigroup.sqldeploy;

import org.apache.commons.io.FileUtils;
import org.apache.maven.plugin.MojoExecutionException;
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

//    @Rule
//    public MojoRule rule = new MojoRule()
//    {
//        @Override
//        protected void before() throws Throwable
//        {
//        }
//
//        @Override
//        protected void after()
//        {
//        }
//    };

    @Before
    public void setUp() throws Exception {
    }

    /**
     * @throws Exception if any
     */
//    @Test
    public void testSomething() throws Exception {
//        File pom = new File( "target/test-classes/project-to-test/genUat" );
//        assertNotNull( pom );
//        assertTrue( pom.exists() );
//
//        SqlGenMojo myMojo = (SqlGenMojo) rule.lookupConfiguredMojo( pom,"gen-sql");
//        assertNotNull( myMojo );
//        myMojo.execute();
//
//        File deployFolder = (File) rule.getVariableValueFromObject(myMojo, "deployFolder");
//        System.out.println(deployFolder.getAbsolutePath());
//        assertNotNull(deployFolder);
//        assertTrue(deployFolder.exists());
//
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
//        String todayStr = dateFormat.format(new Date());
//        File touch = new File(deployFolder, "DeployUAT"+todayStr+".sql");
//        assertTrue("deploy file not exist", touch.exists());

    }


    @Test
    public void test() throws MojoExecutionException {
        File forSacan1 = new File("target/test-classes/ForScan");
        File forSacan2 = new File("target/test-classes/ForScan2");
        File forDeploy = new File("target/test-classes/ForDeploy");
        File forChangeDeploy = new File("target/test-classes/ForChangeDeploy");
        String forChangeDeployName = "changes.sql";
        File forProdDeploy = new File("target/test-classes/ForProdDeploy");
        String scanDate = "20200630";
        SqlGenMojo mojo = new SqlGenMojo(new File[]{forSacan1, forSacan2}, forDeploy, forChangeDeploy, forChangeDeployName, "Deploy{yyyyMMdd}.sql", null, false, "UTF-8");
        mojo.execute();
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