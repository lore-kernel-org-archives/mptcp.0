Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751EC1F19A
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BUunpYqt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MY3igf3WBZCmMpdUNmg1BLK72Hr03KxUrJDT0fTnPWJ3buT4MrecwXRb66/2RWkCwsIjhaYl2wjpx/E7cHWpffr5nZeaRhrRpD/BmrNeHfEkrsAzmbvxD3sKfl1iVZtQ4VUi2NSOvFSpTnq3Ee7rAzmvDU+FiO3BObVk4tR4e/4do9K9TebPuYKOF94J+jEjLhxBGD+wxkDA80hBE0pOLLhB3XyyxXd5VyuoOQe/KyN3fYNS4ldEilGgIxRzcXSlelV+G4bhj9Wvt+ylKsmXOT+wm9Wn12g0nTuVv27gLhCceKrNheSGPgBv0WB4aC7AK3bicrjJcmY5AUgPuih6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teYrpZh7caDHD3thMAV6t+dK2b6nkisfEgovbbzTYJk=;
 b=ihlsyl2fsNuotTX6MJjyNBPplWsSkaPDN5heLQD4x4D1A5pwF8weFzNsixK3aJdHbW4egtlihilpgTjOJh1xZBIhYebtMz2KxBOIZ8D4WnehHDwh//erqTlU3X7Y/wHBz0FmXRvDeZ6Kxv698tZiS2ip3Ak5EIW1sY78RCj/pHIVjVBPtvQ6sTWa2mMMH3//SXOZeFH8fZSPERknBykFRnEL+XTWBt34aS9aotfor/PTV4CaXn0EStyztP7OmAKP6J9bB1yRl+Yz19bXSsEyNei/l9kN7yOtk61VDcCF7YcQjQkSBpW/M8WwG0kUfH+4TUG3+eAjLNd9tKcxpxQopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teYrpZh7caDHD3thMAV6t+dK2b6nkisfEgovbbzTYJk=;
 b=BUunpYqt0Yf+dhBFEGN/iIWzmjgx2OFLsY8GlJ7GAhPoavaK2TO8sDTIt5ZHVkuaNe+9AEkh+OveyejKw341JgY6YH3pL1XG1UzskkkH1j0hn8qJQul+YhxczPHPx5Kwt32nOGVkykUB52Viv9s1ivKt6pD5DPb0w/yLeaz+oWTOwT+SuHuWr7rDa7K0V4FbLWQMjtLWS63+JozUXBLbE4ElTl89UM+QAkubwMyrkW3QiAu9gUqFHFdB7R03v14bS2HGfVQbIUPxM2zJbN5L6L3mCBH7P2Z+m8FszGNMkNekPMWiDtDusxWbLNzcre7vbQnNxcLK5nF7jebC7rdnaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:06:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 09:06:06 +0000
Date: Thu, 12 Oct 2023 17:07:26 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 4/7] selftests: mptcp: userspace pm remove
 initial subflow
Message-ID: <20231012090726.GB30030@localhost.localdomain>
References: <cover.1697031190.git.geliang.tang@suse.com>
 <ad94cfc3e206d76f8e213d66fe2a73d335927496.1697031190.git.geliang.tang@suse.com>
 <1dfb7aa0-34c2-497f-bc4d-89a8177a8d7d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfb7aa0-34c2-497f-bc4d-89a8177a8d7d@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: e569f0ab-9a9f-4e17-efd8-08dbcb02779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+OISUhCCNDf5dOHdcph7b0Rp7ArSWgJGVawjRMWPk37SEnXb6WAX8RdTrQxt9SMlIMs2RIvWs8Pp5ryk8UYJjcD01CY6sol4Vgm/fpoBv2G6wFlUZeCi1itFIn5zFR+RISZgjQR3WiPEl+9/XvxKIReYwkI4nuL77e7zMnuk+dH4Ixv4tUKZje4LdwUQmsYd2ydCXYvkPtdDH324N5Uqco9cdimlgIc6bELxRQPpa0H7oHRQJtXyLbn/rbGt/OT95UUavU+q7jXGXx2BDFLAYuDcPzcCBY8EwENVBS4MhiZv2L3DEreXRhK4M5j40FxcwhgNyP8h81ivxlMQG+AuTiwbOgbD++lmXxQeMqRDFWJM6LYEjJ+KonOfFuDvNcLWurtY0iItm3y0cgQnEXqUdN73Vv2dGnglh9s3lqBx1e7uMpddOY58+z/GNzv8Low9QabnRDxs2edgnQoYvQTKwpAyPpunFLITtPOxtcICLg3Vrdy4IxLPAZkxqqA6BwBdJIkzjB43Yhpld17/oAuoXXFsfRyI3J1daOHNrTG4vxWoamCmdKG1DR7IHjqYZT9c7z1PR7mg6IQn5RSWfOxHCqahMRtfKm9FluyfjyEyGsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33656002)(41300700001)(83380400001)(53546011)(1076003)(15974865002)(86362001)(38100700002)(6512007)(9686003)(6666004)(6506007)(2906002)(5660300002)(44832011)(6916009)(66476007)(66556008)(66946007)(316002)(6486002)(478600001)(4326008)(8936002)(8676002)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UQKHE1doo+jyL1fSAEHHG2Tl+fS08L3bDPyisG0ewhHKXKHOhpW1PAOTCPX?=
 =?us-ascii?Q?l584kJbwytkC3IVB3QkHr03LamEv1c7DtA9VfaGE7tpko/zbWZzAGBaUsXgP?=
 =?us-ascii?Q?+/B7YxSDU0C/cPU4VRzWE0eZIdHsDoHbXSE+o8fzUnTZVsqOz1kMTmr3WFhH?=
 =?us-ascii?Q?RmscJgY3acNR1DCjlV364+z/Su0mOrZFpQABeKbFrYbved0ZHESus4roK4H/?=
 =?us-ascii?Q?TEXgzveaUmpDW1V3kjPyTQRvXhrDrGCCvDQNmwDNNrxdLr3ft140zTf4h3n3?=
 =?us-ascii?Q?5s86wN/bcxbGD5qFJmagoz/xpIXOVr17c0QSVPBSkDKIc39Ou7EKOcGfUPhp?=
 =?us-ascii?Q?GQk+fgDzUs7Q9wIG6rP6wLPvCTE57z/C+74mEOUlv+So4Z4rSuGV0dC0vE0L?=
 =?us-ascii?Q?ugDiyL/wf1eb3h6W5f3icck/bSRo16aQZTN97OVBnef1wjmkpNoeSumuC9dG?=
 =?us-ascii?Q?O4dxVlrUS2jPioJNtZgPX56pcDh0xi1I0Yk+NWKWbLQ7Phm/Zw3t1kYqh7+4?=
 =?us-ascii?Q?kM/P9H0dUKkuY7IHiKoMbkjEDADuZtdEKYYaAgfJCnxLR7dwnoazgRg+3SDq?=
 =?us-ascii?Q?9Q5Nha1AVxP3nt07QXz0uV7pQLQ63t9qbJDWQw5MhbaGgYS9HpRqjgmyq1jR?=
 =?us-ascii?Q?zla1Tgj6TEQA0Jz6emaUyzWmlETvB1m/41BZoDltnvGcsf47cX1vkrKAkAhU?=
 =?us-ascii?Q?gXvusnMwZlvWS0givCAVvSS6zWkFiUC8JD+oxJD2c/wFSRb7DI2AVn3jKfsG?=
 =?us-ascii?Q?UH5Mu/1UQ+W3lD0F5Ew2RIaL9Hf+Nz2APc4uFg2hEz+TyeYZxXE614+uuUQx?=
 =?us-ascii?Q?yoJSRN2bi+mVwzu7S120f87sQfar/JuCh9a43a8JTl4cWXWlm/HmBiOPtrCF?=
 =?us-ascii?Q?2OiyC3r7IaSGMCfnRTbTStE3hYIKkFb2AldkHBmfKXFyRjmKLm6aFxZhdLwb?=
 =?us-ascii?Q?+phIDo9lrXwJ0yr7mIhZ32Q5G55g+V3ewI5WCFADpoyI8Zrm9T6QZybF1LgP?=
 =?us-ascii?Q?ZCV0VEb0xV2HvXe1DDgNW3z6gtWCzL/1hF8Qtf9u/lwcP221S/LKr+Xls4n5?=
 =?us-ascii?Q?Io9pWH14mPF1B95DQ5Ksz5ZjpsZlFWMHLg/B+LE1sDhM4rnCfRz5OF73ld38?=
 =?us-ascii?Q?7fVWIgO+5HRd5O73s0ppuHpCq+Humme2lWnbFah9niiRaKgVm3ars8HPlzdc?=
 =?us-ascii?Q?BrbNLFWgJvnQNXrtUFA6p8tiwC3kKrDv/nAh02nKNqgyOPf44zqZdX/l5LrZ?=
 =?us-ascii?Q?RbnxNxDcHZ1HSzFw7UGTv1yx42NvUaIOvH4omALuYYCvkLoDOfFKIwKh6CGt?=
 =?us-ascii?Q?KLY/Y7D69WCOvRQ0xeXUXxd2nYwUPFSliJn14YGWs4QSfNpUqt4Jxej9hl22?=
 =?us-ascii?Q?IGCqfv+N5IVH3CcBSRNTRm0JjZUCunYBjfZxUc3O0+qttzKe0bodr1pbjGsD?=
 =?us-ascii?Q?RayMtSuvpoiukh+zb22LKuXqHTx9pYtwGxjGtwxq1NRgqOK9z7wATZQ5mwDF?=
 =?us-ascii?Q?YFcL7B081B0e9bQqr0QPG43MGvGcQz8kVqN3GCkH4PTRzaSLVKFZdm6CDlX5?=
 =?us-ascii?Q?98g8yMGBgMQymhdpDG2j+8BDRi6xM4eEvBv63zQDL/2vNza+6Z8ySEaZLjVu?=
 =?us-ascii?Q?vp+/qZJULbGHylIgOy3NDlTxraZtAme2fXXVXCSSk1pi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e569f0ab-9a9f-4e17-efd8-08dbcb02779a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:06:06.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tn5Yb32HvH8lVMdVR24axddTCKdWnL94kOZE6w+zzXDxfqZZXO5Hts3BKU5NE4XTkpNY+/assJJTZAlIUp6E0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8840

On Wed, Oct 11, 2023 at 05:57:42PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 11/10/2023 15:34, Geliang Tang wrote:
> > This patch adds a selftest for userpsace PM to remove the initial
> > subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
> > ip address to userspace_pm_rm_sf() to remove the initial subflow.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index ab6908b7b143..e1304383057c 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -3507,6 +3507,28 @@ userspace_tests()
> >  		kill_events_pids
> >  		wait $tests_pid
> >  	fi
> > +
> > +	# userspace pm remove initial subflow
> > +	if reset_with_events "userspace pm remove initial subflow" &&
> > +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> > +		set_userspace_pm $ns2
> > +		pm_nl_set_limits $ns1 0 1
> > +		speed=10 \
> > +			run_tests $ns1 $ns2 10.0.1.1 &
> > +		local tests_pid=$!
> > +		wait_mpj $ns2
> > +		userspace_pm_add_sf $ns2 10.0.3.2 20
> > +		chk_join_nr 1 1 1
> > +		chk_mptcp_info subflows 1 subflows 1
> > +		chk_subflows_total 2 2
> > +		userspace_pm_rm_sf $ns2 10.0.1.2
> 
> If this command removes the initial subflow ...
> 
> > +		chk_rm_nr 0 1
> 
> (it is a bit confusing, we could think there are RM_ADDR being sent
> here. If you need to change something else, can you add a comment here
> that we don't look at the counter linked to the RM_ADDR but to the one
> linked to the subflows that have been removed please?)
> 
> > +		chk_rst_nr 0 0 invert
> > +		chk_mptcp_info subflows 1 subflows 1
> 
> ... that's normal to still have 1 "extra subflow" here but ...
> 
> > +		chk_subflows_total 2 2
> 
> ... this should be "1 1", no? One subflow has been removed in between,
> so we should not have the same counter as before, no?

It will be "2 1" if we test TCPF_FIN_WAIT2 as well as TCPF_CLOSE in
__mptcp_has_initial_subflow too. This is no subflow removed in ns1, one
subflow has been removed in ns2. Patch 7 will get "2 1" too.

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
