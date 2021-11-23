Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B22C94
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 11:11:42 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so2588353pjb.5
        for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=MyhRuSyjyp3rZ0qud8m6ScUOVb4rsNRckrTFPD70q3g=;
        b=hDHQ5z0zlL8hiIEOXYVV2ODdaT8jqWuQRT1BlnwimvtVD+uPCzi3SQJZ7hFzAw8zrs
         kTNusCtvxYHAePSX8LLioVtaOAy8Bq8CFCPPKeZV3+PabSGd8QK9/9qYf8w2s+WRY+7c
         V32WT1oQOjtleV4qFeMiPcjUGU3UZNxWkiiwGPg8X+er19/H0j9B88uGhgxiIUV25Zhc
         dbpz0zPhqDeuYie8DkOFRXGwoNANKFt7rVrbYGO4SeCr8lcdkqC5KXVrj/eX6b67JofZ
         NqOvOCeMzaHRrRiTFUVs8hpDdS+Y9kOdRHmXk+TfeT1YosvbAHA6gDcUOmO+TGPwjsXU
         1RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=MyhRuSyjyp3rZ0qud8m6ScUOVb4rsNRckrTFPD70q3g=;
        b=HFmYoO8NiRaDkGNnOu8kggiGtBzwFtCRCo9UA59dr+JeFxyduzcw/k+Lm3lWEwKAB3
         e0xqIlJZ0yNXEHbnR8xTKIvBQFurIHxgpb0yujjDq+3AZkcImu3nUpJaMBPbYndozRI+
         lrAGRjA2npRLDywtW99FPoVMg4M2591zq1Os5r7pdIUUt/IChOSkypl5AwRyV+c/BWS4
         d8j/bfb20fBTi7Jmf1rQ5SvZJ1Y7uDKM/0ZLk/nCWGd3ATrwkq83LXUZOkm6OgaEgKz7
         Mypj1vMqSztFcuLpNTnzZQi1h9bRszEXULoBrAkbcKpuBwlBg/O3QIQEJxUdtaIXw1/H
         vxrA==
X-Gm-Message-State: AOAM532vEOo9ullNKRFOzed8RFw2kJ9Sy0UqT2CqSbYRmkcQt0RYFgyq
	1DNhpPufVzWvtt2pjPtxRw==
X-Google-Smtp-Source: ABdhPJw7Z5jIiQG87C3Z8io8RiHrU45aRTvteuUSSRdN0TPs+/NPdq0AeuVkHBUPHu2cvgN7c4TzSQ==
X-Received: by 2002:a17:902:f691:b0:142:2f7a:308e with SMTP id l17-20020a170902f69100b001422f7a308emr5752464plg.19.1637665902128;
        Tue, 23 Nov 2021 03:11:42 -0800 (PST)
Received: from [127.0.0.1] ([20.114.21.81])
        by smtp.gmail.com with ESMTPSA id a13sm14321168pfv.99.2021.11.23.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:11:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20211122152651.28466-2-fw@strlen.de>
References: <20211122152651.28466-2-fw@strlen.de>
Subject: Re: selftests: mptcp: check IP_TOS in/out are the same: Build
 Failure
Message-ID: <fb1fd660-ad41-92c3-bb3b-2e0aad740dc4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Nov 2021 11:11:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20211122152651.28466-2-fw@strlen.de/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1494450178

Status: failure
Initiator: matttbe
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/65da757c6e14

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
