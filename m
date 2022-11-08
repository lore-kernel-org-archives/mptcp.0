Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E3323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 07:13:37 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id o13so7063489ilc.7
        for <mptcp@lists.linux.dev>; Mon, 07 Nov 2022 23:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgQado/dExVVjgMBOCg9Fv6QM/5GxeaeSPme2xCRxmI=;
        b=cMmW0PHe28s7VBGOTJPVxAzAU6p3P9xN2T5puxUAsbFGzCs+gMWjxrk9I2E2N5q5Dw
         1dc1Udq2PUN07OVBbyuI9sDeoySJWn6zeXz7z2UlV2i+WHteTlpmKbRbfr6LR/p512TB
         AFZh+uXRAz+UysUEgETZVgGRqSPrONCA2sABGnUEf1oVtu1LKKtQQw+viYXgBB7h7PPh
         zMRtlLCv4iTzxi/u15PJKYOIoPUXzWt5VrBzfgDbLYQM+RGCEPBhPwpDWJEUy5ytthpf
         JdsKHwyFrN17bDOhIquUl+3siaBgIAUCIOKQ4Kwo8Z5HhA768ZHv7vvo8XWyEDvHk7QX
         MrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dgQado/dExVVjgMBOCg9Fv6QM/5GxeaeSPme2xCRxmI=;
        b=YC+s9qF/G4F9yfScvgu5e/reT5Dx+fGfXEAiKCl7Rw7hLXJyD/zKK7hPa9mSP7UO4B
         Se1jQ69xO+fUNWtqeBn2HOJotpIaCmECFtPNCuTEQAFP36r8WfI0rl3PbKtTK+/aLT+P
         SA4arXa0Cmg0BYtF5x8U+aTASMec6yr0WxCQ/86nJCMcZnUbjlI+PaBj61zkHUh89H4e
         Bu3pD/9QxRBS5Xp2M/sBlieryDvfAlSQA+9tknFHiyZqCF/bI2SoB5SteXkjPfnYWQFc
         ZcwQoMrYMS5LBilGFIOfaxh+9n5C7egMVsKQIJK9owGMtG7ouPa/dpO96xeHKTUgRyMZ
         C3SA==
X-Gm-Message-State: ACrzQf1ItwkQIWwA3MdBBmXdX7oujiRiS7GXZEzZ2WxtSLsExnw1iwVi
	dYwVdsnXuuO/ZipcntFWjlBTIFHtdQ==
X-Google-Smtp-Source: AMsMyM63gbM4hVozOeQD6hWarNg+eScfnfUiONXNtN9lmd7asFXYFaVpAC5TvzMUw+FBHMwGmjAKxw==
X-Received: by 2002:a92:6412:0:b0:300:98a1:db42 with SMTP id y18-20020a926412000000b0030098a1db42mr29352567ilb.16.1667891616448;
        Mon, 07 Nov 2022 23:13:36 -0800 (PST)
Received: from [127.0.0.1] ([20.12.222.164])
        by smtp.gmail.com with ESMTPSA id x13-20020a02970d000000b00365ddf7d1d8sm3416940jai.53.2022.11.07.23.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 23:13:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bdcd868980996e3b9ca84b361ab5f561cbc2d0af.1667889809.git.geliang.tang@suse.com>
References:
 <bdcd868980996e3b9ca84b361ab5f561cbc2d0af.1667889809.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Build Failure
Message-ID: <2d7171cf-a435-c3bf-0104-e358c3d51473@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Nov 2022 07:13:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/bdcd868980996e3b9ca84b361ab5f561cbc2d0af.1667889809=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/3417050364

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/5906795b5b=
b9

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
