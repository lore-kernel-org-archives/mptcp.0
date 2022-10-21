Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709B7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:33:06 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id w189so871303pfw.4
        for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0MDoHt1FDthVmVIpnXsG7oCozxw7QmwpF7pLakAHP0=;
        b=SXYEPWhdCrwjvU4W4oxFRNapcKKU4poFIteS9hgkWwASPQcFKP4GcJvHvdRyN6A+TM
         GxQdO9QjxPw4LJMrpcSX8BKmAXeXRB0D/RE2s2cJ23nNhdg6uPpHIB9QNULl3/g5xv+y
         XtEGpN6SkK6++68Wzafenh28nW/0T85GGJQ4x+hoi/SK8Ix7N9hYl1cP3V7u6XjiRSWT
         R86jAo8TasqHIA3xf0Cwn8Wxy9XENAMhqx+9Q5pgUijTpmkpgDxh4I/ev1Qg7lSULGph
         rae3L/8HNaxqj0n4RsuLR/I0XQ96jgTS9nvL0buAG3/sFSCFDjf4V3CVlt4OWskQSM0m
         S6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0MDoHt1FDthVmVIpnXsG7oCozxw7QmwpF7pLakAHP0=;
        b=U4uH4gBVF2xYbHmYSFgYkJU4Anb9viHvvWTiboIvoH+LCMacIj1JBzyzGfG6wHx4d/
         4G4PyVtiuY0An3weR9OzFTuk37fDlbxig8XQiSelrGXEruylaWgopIS1SqOtESi5Xll9
         +A+QprdZXNnaWgDoH2iCdESy7KTOIUQdrJeBUY5bsgfp1cJc88z3F16u4zUxLEVAnApT
         FDpbomHQx0g+vYdDzjpXF0+F57a1jkLkQJTz280DvGf8w/TP+vR/2ezWFQ5PT2Q1WlYI
         FplltU2AKet0R4EfYZWq9MF63pgwDVvvM0JbHkjOoPplRlYxGng86T/5vFhacApetdcm
         hYaQ==
X-Gm-Message-State: ACrzQf0yRkPWSjnxxSOcBzwqJaECsc4eaLuG43hOKFdI2F4tLaKp2Gjw
	Ctr1694XOr/dVS77+T+loqP9WjzNLyW8
X-Google-Smtp-Source: AMsMyM427iozG5Azl01T9A7djVnp8ZoLmqi7blTWOPjAP4l2MJP/nT4jLes+frYmpoClupnf7051FA==
X-Received: by 2002:a65:6e0d:0:b0:42d:707c:94ee with SMTP id bd13-20020a656e0d000000b0042d707c94eemr15391167pgb.260.1666351986058;
        Fri, 21 Oct 2022 04:33:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.150.12])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b001781a7c28b9sm14590739plg.240.2022.10.21.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:33:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com>
References:
 <b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Build Failure
Message-ID: <e99c113f-8c26-5e86-4b79-c53ddb5adb03@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Oct 2022 11:33:04 +0000
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
org/project/mptcp/patch/b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/3296922773

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/28f79fa98d=
cc

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
