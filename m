Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4D1DDE1
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 23:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691624360; x=1723160360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kyAxQGFuJMwqgn4sdfOR01ZSFdddwe/pBJtWI/DivcM=;
  b=m9b7KoB9rX5Pz60hAYByMLOw/QgDqkO0B2lVKL2EQYHwfDnFiKfrvlAY
   FnRZ4oCAkThyvYBrpkJX77I2GJV0slxI67ZYgsLJ4NCo5klgQBGVZU40C
   q9tzME2qjr+glYoWVyLyOABP4s+xMKLhiLHOD9hc4ynpU90dQ/XwzpExo
   o=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="665495773"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 23:39:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id A87258A0C9;
	Wed,  9 Aug 2023 23:39:19 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 23:39:19 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 23:39:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wpasupplicant.patchew@gmail.com>
CC: <kuniyu@amazon.com>, <mptcp@lists.linux.dev>
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Build Failure
Date: Wed, 9 Aug 2023 16:39:08 -0700
Message-ID: <20230809233908.26135-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <eec230ed-7af2-c055-5c6e-9c70ff454188@gmail.com>
References: <eec230ed-7af2-c055-5c6e-9c70ff454188@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: MPTCP CI <wpasupplicant.patchew@gmail.com>
Date: Wed, 09 Aug 2023 23:20:04 +0000
> Hi Kuniyuki,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/20230809225918.21523-1-kuniyu@amazon.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5815022877
> 
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e7b0047cdbb4

Oops, I used net-next and missed f2b529788d80 ("mptcp: add sched in
mptcp_sock").

I'll rebase on the mptcp tree.
