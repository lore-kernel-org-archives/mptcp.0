Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5476ABA
	for <mptcp@lists.linux.dev>; Thu,  5 Oct 2023 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g8XsHBKU"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3qN4TyRU1zpCeBMN28p3Hmb+KfoQzfAp4f5iCzKYtWGsMqbH6uDqGeuTq1Wiat2AK/EN7Hh5qjcK0ujhDLEftpbtKBcGVKP98vrS2Nrg+PJVEGAp7BkZNs2S2sSJot1zQ5U6eOmP6aLdzj0uhg/BZ4YKdZtG2VPOz8/9b9V4DDIHk1QlQCyoYiE+B8F70IWT/CchiRpiqDFsRCcELC20vG8wb2nroGCbQsp9aRdsyU8TjGizGo9b5TlX8Y5DokjW82OIEFDsTi2AjOdcjWhiEBEEjhl7pye7FwJ5zOxJcT/ISHoc8/YoAUTqGKlazx1n5SJkuw0S8FyUZruKKtSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvlQQeT2vhVTcK7zdzeV4Aa/FeuZNjyPBb4T/5oj9o4=;
 b=nP0oVzB7yw0M+ZzVV6aYIVloIbKrYX19NCVNzbtDWUoiMauzvuAxjqiQVzq2XS+P9sGbwZ5UCcw40eKJsgSJBxIpiGoW2iDTGkOGAWHozz2HdZkQIGKIHddoPcOpZCKlERyqBITzHTI/K4HATa979zDvqhKaQUhQ//V/JNvMNRcvAP54ZkMH3TZAl0v4J/zKGYM5f2h8QDwslFolF52CAyYc2o8WTeDbKVP/fSXtkBlzlsOBMJbRUa5mGU6ImRQQiCn3h1I1gsl1T8GVv5SXvAWGciFNBDYENdgO7aoWq5EA3kQQsG90Awf2va3QKbWZQpebFHNHVNtqzBM7DG5+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvlQQeT2vhVTcK7zdzeV4Aa/FeuZNjyPBb4T/5oj9o4=;
 b=g8XsHBKURSQwMeETyLLNv/dMyNe5LKX5EQFWTGqYFe8Kujtv2HEpKApZp8VpNOzg000Z5SHLl0NRa3Fla7nHhF014+lQDxzb8omIPmqlrwrF0aFEgcRj1/16qb1d2c19cNJTVdG0l+LMTRN7bAf8Z8f3AjZPzoQc2q4ECKW8D4UsrrnSK0bIC86tm7/vLqytmdFoPvHjamMScC2fc17bC0g7/qeoRg7iTxSdLbyL/6wnK8TrAQ007Daa6A2wFvfYEJ1OowepAGqt/0VdiMXgdpUZpzeZmHgliTcdYI6ZdoXJk7orma+TUmqy0e7MkslAkYAv3WuOP+kAn8s6v32elg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9472.eurprd04.prod.outlook.com (2603:10a6:102:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 08:31:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 08:31:07 +0000
Date: Thu, 5 Oct 2023 16:32:15 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 12/29] selftests: mptcp: userspace pm
 remove id 0 subflow
Message-ID: <20231005083215.GA23632@bogon>
References: <cover.1695631132.git.geliang.tang@suse.com>
 <04438bad0ef7459b1a78fa88a6cd2e2c31ebf616.1695631132.git.geliang.tang@suse.com>
 <5c715ddd-f8de-4b64-8dab-4d3ad10c456e@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c715ddd-f8de-4b64-8dab-4d3ad10c456e@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c3c6cf-a660-4d73-cabc-08dbc57d6bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EOCNPrSHLiZtjNQpNHI5f0rXlVZ9LIPxL3XwmPlBg/XQBzZFQWFD8mnhhlo6FwsCezzfuVNOGOhrC26StiKo/k0Ov5So8ZI4f4iDYznFW6c66rMTRubJM+CT17zDAhqc+6iaLrjbpxYevehFwLAJnNgRYUS1rFQ7d7C6G4wpLJHH5oiowWxHalOEi1u7L8zFWNzgUbnE+fmt/zV+kO5zNAfTYyGdq4ge9/zC0QDj6aPKbOaDQVryoy8vncBgWSmERfliWPTO3toEr/Wz+vDgv9Skgge4uixWwxWePDWVuDV/dUHU8kh1fCRBc3BehEV2o24DK+ucsCDB/AC978iOGYneuHX10LTAprBXe1ZFh4Hp59PmE6OXWQTrG/KzVoPRT74uGjh/G2Owzk3MzihDZYvqf2YP03LfdybgBivxLX8wt/LteVkKGru0gzZPGdg8v0iXq7LtmjxYskwfbdkZKho4Lw/vEg7i3u+d6iNtE76VZ9JUAaXPLxGUb9JRKUYW5eTzWZSDC0zivzETSqD4KUmNwk1L8lWDZBpOmw+BFzjC5KaZJPwyCYQIyozP4YmZYvEGUvudQepR8ZPjOaNm6J7/SsS6f8ASX1C6NlHvf91weHSk57vPYpBleU3kmbla
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(6666004)(6486002)(6506007)(83380400001)(53546011)(9686003)(6512007)(1076003)(26005)(4326008)(110136005)(8936002)(8676002)(66556008)(66476007)(316002)(38100700002)(41300700001)(66946007)(15974865002)(33656002)(5660300002)(2906002)(44832011)(86362001)(33716001)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+45lztq0iJAhSEY4U7OcKzLZwbPSUbp23Qt4NtKU7QmgWnn7WbT83XzBpEzx?=
 =?us-ascii?Q?NbIEnrsbt7DNtoU6ov04Npa3lyaqvutxBKs0lXDIkkCXXOq0eszaUEqfc3Av?=
 =?us-ascii?Q?e4B4jAgh6cthRYHRuwVc240sID1eE2jK/4slFSB2S/BQIZ3I4/ETKU6Xu+ku?=
 =?us-ascii?Q?IAhjafcHJOgIW7PlAO3DIsvDasmGvWWAYNLOUialgMPxTJ1Nxa8o5fAAu9E/?=
 =?us-ascii?Q?+hNZKK5QF5hYWe6vujG5W5M89rP+j4jQKRR4ep+6lG2wpBV9fnJWMuJVNDKJ?=
 =?us-ascii?Q?lyNNnfVqcGoD6RWUJUNF73WFq5NeA/BKuqgY6TDnsi80+ecM3QwdbWhZuoo9?=
 =?us-ascii?Q?Su7o8T+BYcfcPWmNchfRcwdjxjh5kcBARISXBziEGDbtk60FLrrsJvCYvPPP?=
 =?us-ascii?Q?1+t6uGV+S7b1mNnSLlnJbL/F/oPJGrWTjPeDMW5hEV26D3XnpZYxUj8m0nJp?=
 =?us-ascii?Q?cZ7ICWBl76sDC7NIwxv4n+dcKK3kTzWQpi8HKr1RfYvqzxXXl+zssfTBIKev?=
 =?us-ascii?Q?gF+Pa1W7uQIRuCLu0EUeXqYtjvzIVy/GwyM+l0VoZXjE2LMbsZl3OthS/EdI?=
 =?us-ascii?Q?C+7vFeJAAQasFsIWB0FUdN/cWiussvCbzpfIewZY8bYOWPSOzMqQazCOzFXc?=
 =?us-ascii?Q?bon8pTAiRnJl6m3inqTM65volBM9qKn/GAGF3IalCPKlVe5qqyYdjkVSIIOU?=
 =?us-ascii?Q?EXQDC+gAXrBEnH3788j4opljRACFsZfE0ZFxNTEHWhjGrEphxSIu7CVCE7mG?=
 =?us-ascii?Q?2HEfRsfYfltAjjTdiq2VZlpyN2fOFRth+8wFvWmNt/fD3WwqSkvybfBg6Vs+?=
 =?us-ascii?Q?kRQy++h3eyxKOfzB2KJxZQaiov0LiDn6eeNpatNSBDhBrXR/gwwNODkpmmch?=
 =?us-ascii?Q?ajYOf/qNcFbkXVsJpD6zXehC/eIAoaYSwfwsf4eyhyY0Nw/JgzkQA3aHd7Gj?=
 =?us-ascii?Q?r8Bgpviwf1pJSIPhsONBcBhaKLMpAIWUylzf+2apqqbNm5tXODirvFv8IRaf?=
 =?us-ascii?Q?S2VzzfHQxZ4MdKJsXIaLlCxeUQLI/pC46z0aG4ytHdNRCNim5H7Z/cDIbKHW?=
 =?us-ascii?Q?JDXnjqDCjAwQdAIS5m4euVS2mtpUxP18LfKGtLjpkE5RAcRLnFl5oahcJ5mk?=
 =?us-ascii?Q?xGiLE13w7U/MW5KxlXSVmq+nTBE7uvFBQdqmBoODlWDfCb2vlIIKVnMkPgFC?=
 =?us-ascii?Q?XOQH0G2yaJ/aHJ153PAcHlQ3qF71BQPVgmTSQw8xvoXwyEn6S97JSDysuaDV?=
 =?us-ascii?Q?ivLqPF/mXeMWoq2vHjEfLyqHZIIedplEo1FR1s/Tmknq1RZHStCQfXHle/d8?=
 =?us-ascii?Q?7wIX2u+CkxCQl3/S1EUbq2S37kGd6RpYarbZRyp/QwgUzHZdrAkUSGeb9KxL?=
 =?us-ascii?Q?ox3783K64gK6vvr2Dcda3S8+dtOlSHUh4Gl/e44JN+xb/XYB9mDA/KjjfBIM?=
 =?us-ascii?Q?g2fbF9D1+xF0QNBZCk1l3b9jxL7s5O5OZaRuQ/H1UVWoWYmGydS24/X4XgQL?=
 =?us-ascii?Q?jNQECtQqU5AHSQUgd3VahkcyczUg3tFvAZK3c18pf8x14wP7M48Vdu6aw8Yo?=
 =?us-ascii?Q?fqMgalupYf/dmg8LMHU9gqFW4FXYNUxL6nR6pbKt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c3c6cf-a660-4d73-cabc-08dbc57d6bd3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:31:07.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nm/vcWikCrf96G3+1COtASyipHnytYbGL9zxqQypCMwymmir0Y3t+bRS+LZii7Q0A2YPqjex0tJWfugBoZT63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9472

Hi Matt,

On Thu, Sep 28, 2023 at 10:58:33PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 25/09/2023 10:41, Geliang Tang wrote:
> > This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
> > userspace_pm_add_sf() to add a subflow, and pass initial ip address to
> > userspace_pm_rm_sf() to remove id 0 subflow.
> > 
> > When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
> > false, then tcp_disconnect is invoked. This will send a MP_RST to close
> > a subflow on the peer too.
> 
> I don't think we should have a RST (with MP_TCPRST) when we close the
> initial subflow, no? We don't have that when we remove subflows with
> other IDs.

We do have a RST in "in-kernel remove id 0 subflow and address" tests,
we can test them like this:

        # remove id 0 subflow
        if reset "remove id 0 subflow"; then
                pm_nl_set_limits $ns1 0 1
                pm_nl_set_limits $ns2 0 1
                pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
                addr_nr_ns2=-9 speed=slow \
                        run_tests $ns1 $ns2 10.0.1.1
                chk_join_nr 1 1 1
                chk_rm_nr 1 1
+               chk_rst_nr 1 1
        fi

        # remove id 0 address
        if reset "remove id 0 address"; then
                pm_nl_set_limits $ns1 0 1
                pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
                pm_nl_set_limits $ns2 1 1
                addr_nr_ns1=-9 speed=slow \
                        run_tests $ns1 $ns2 10.0.1.1
                chk_join_nr 1 1 1
                chk_add_nr 1 1
                chk_rm_nr 1 1 invert
+               chk_rst_nr 1 1 invert
        fi

Maybe it's OK with the RSTs.

Thanks,
-Geliang

> 
> I guess we are not handling this case properly on the kernel side. We
> should close the initial subflow normally (with FIN) like we would do
> with any other subflow IDs (and here, we cannot fully destroy it and we
> still need to keep a valid ref for msk->first).
> 
> > So chk_rst_nr() is added in this test, and
> > chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
