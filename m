Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D46FB2
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 09:38:59 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-63008f9293dso33831816d6.1
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687772338; x=1690364338;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsYOumbX6PsHLWIXZozXyMW1AO+0R/kSB0PFGID60Ts=;
        b=pXVioWD4XBxAGfWZt77TzzNVqebh+I/t7w6yL3YDzogrRhBIZGsu/5V0Sbxbv8qmxQ
         5etRGSdPm2Uze2o2Qkyfg/Sp0Pq5poZr7q8Z5qo/rb3g3HpW7jmSNYxsN32lktVwS6o7
         lDachWGzLLg5zJjzUJrfxyftlNtc3woWm0Xz/YQgVMfrzFHaBISndGTq26060htdgA19
         a+hmnx2I8igP7enu4gontdFlt6//U5CHLve0MCXbU4Oa5Ev2lclhv/VYrl+c6VSBv9EN
         wmBpBoMoVMDgaiWXdKr1M86i53xbbhfC9wFAwHboxeWIBGV/KQJLUDVlTLJ6ss+6589n
         E+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772338; x=1690364338;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsYOumbX6PsHLWIXZozXyMW1AO+0R/kSB0PFGID60Ts=;
        b=JD8ZENypEsTWXxjjgkUqR3SjkmHT5L4OVwbpPi9gH5zuO+980Ge3BRh8YuxHWttzFT
         ywih0ZCJ24wlVg5I72E1iwYCRq4tMr7TkjBoWr4BvxLEPNRsRQi/TjjoeQI/uMIIutyL
         b/qB0HZ5ESpqf+zH7hB5P6tEFg8/Fu6LeSf2n5h2+bWLuXPwDoPfFBLcbMwX/kbMyKNt
         lCaSzemWpJpeAsl7pRmC+m9M5gOlQBMXH64jc0iy0zkxYK7lZNgvYniO8Ud4CU4ErvlW
         DPvKjbGFcMl0CawoGhiSw9p8Ur8WOsn4fq7wHALqskgZ8XQFVh0VuRDwfLQwnthQslRN
         K1gQ==
X-Gm-Message-State: AC+VfDx5tqNyrh+rOcUY2VQkVOovdmdFUSNxSR7gzMoiO+fP6uoVq1uJ
	V649J1GxIfeXsZxK6fNDOmN92SCY8g==
X-Google-Smtp-Source: ACHHUZ6TzHixO7eoTZrrDCucQ3nUWAr2sYaKVmHmHJZNoCNbZ6pM5oxB7WbQHTEwwl9IzBEGdRpq4g==
X-Received: by 2002:a05:6214:29e6:b0:630:6926:d00e with SMTP id jv6-20020a05621429e600b006306926d00emr27622660qvb.39.1687772338162;
        Mon, 26 Jun 2023 02:38:58 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.235])
        by smtp.gmail.com with ESMTPSA id ct15-20020a056214178f00b0062635bd22aesm2917465qvb.109.2023.06.26.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 02:38:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
References:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_scheduler=22=3A_Build_Failure?=
Message-ID: <b5060820-0e03-be0b-1c46-b0831561d1d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 09:38:57 +0000
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
org/project/mptcp/patch/cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5376448855

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/be983431b4=
a0

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
