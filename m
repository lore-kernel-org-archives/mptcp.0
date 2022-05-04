Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9A2566
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 11:51:17 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id h3so619739qtn.4
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=qOnnVwf5UGmfHBNyCAiNvO4K0YVtyMBtMQ/1jfu01sQ=;
        b=JSbsvPr6eJGX5odLuKXJ6XJQgQFsWrCFkrfyKdo4ms5ZrtvCOD14waYUAiBYJaRyCa
         Ig+LDGEUHQAR8qsp4u+mYnTftMEXFVuQ85Nb36DsPj20R6HdS6zEpUypalrWXQgN2vab
         804xB2cXnpJhjmLJq4PvEjecdtzobleruPe1vLIrwGfnLQi4yQxvlvPYAi0BgfVOB2Eb
         GVpUWFVmXdCCbXKSoFhzkH7jDyrPTu+iPtaB7wr3ApY9aRXTFKP2OcWREFCsrKqMKiDX
         u/kCQyEjVXTiAP0TnE9sU4EwLxZZmjaCi+LlYsBTIbeT7fME6z5j7siK55e8FIReJ9kd
         vaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=qOnnVwf5UGmfHBNyCAiNvO4K0YVtyMBtMQ/1jfu01sQ=;
        b=HYd6CGgGjYkYUpt0BE/bP4/DSyJ2KZWSEjyrTVgNJiQLtcsJbjFGnRiAD2zDSIyWk0
         hYau5oAQv3+eeHK5/NVfnV7TdRLknxHcbXszoeSeV5K2QD0PPBTcgoK+DfcTHdm2Mtx8
         vxLmHckj9QaVJSK9f9+LLTMM6sClmZoTEP4f4cUFLc7c3M1abNrBuq59pLm47D+GoyR1
         IBC3X6IRwsaylK11IpZxYGZDn60XP+R5fUhjmDgqTsedOECt984+ts0rxCU8kCiFDK8x
         1NBOU+2wbwuxnJlGOj2vQ5ROjmVmSqZcogB/8zRfNHTVz3Z0J8mvSKAX3c216elfy5R/
         CqgQ==
X-Gm-Message-State: AOAM531UYUZgqv1ClIwOGRD7ABIPgOT1sGp7BcL1qrighv2ALYq2BH6z
	X8hmpX2TBO9Y17JIPYcWyA==
X-Google-Smtp-Source: ABdhPJzbS9Css6EuCOsLiguKcglMI/O/f4k5XJ2ktndXlGOYaaQsSDphYBJsrBUHwTuRwwl2DUgBeQ==
X-Received: by 2002:ac8:580e:0:b0:2f3:7ff9:39c6 with SMTP id g14-20020ac8580e000000b002f37ff939c6mr18883226qtg.434.1651665076609;
        Wed, 04 May 2022 04:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.94.80.49])
        by smtp.gmail.com with ESMTPSA id 140-20020a370492000000b0069fc13ce1e5sm7583714qke.22.2022.05.04.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:51:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
References:
 <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_MP=5FFAIL_reset_testcase=22_-_clean?=
 =?UTF-8?Q?ups=3A_Build_Failure?=
Message-ID: <0d9db56e-e48f-95c3-1ee1-d6a6d2fb0089@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 May 2022 11:51:15 +0000
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
org/project/mptcp/patch/cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2269548473

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/cd2b6a8875=
41

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
