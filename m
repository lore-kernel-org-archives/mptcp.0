Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5C2D7DF1
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360708; cv=none; b=Q6jTOOolYrPcxSFfmRAn77ClSegGBjio0B/SLtaZcrDIYkprSRGInDwAkLc0VEVA1HcnuZNoCF6jPMkJswFYzqqv64D5PP4dot2RFZDkX8sck1KFx7ZlQyQceouyGyWC8xTdYXGmrmsjGst7c6nbm1PwJis2QlwAI1eY/ixJNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360708; c=relaxed/simple;
	bh=ie8gFJ1tVRo4h+fTC8p7CktvVIGC8GqCkWVef6gjbew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Mx7wJUkb1RXIJKC4JHzC2p4WmEWHu8XmCDhtDtar2VPM6v/X8wYA33QygUtt6LODM440NG8uO53qjxI+RMXiDVrl80uprAkdcCvD+Pyx4PL+S9mZTBY2siy9dpd5dzY5U2uhpU4F7A50MGxwG+lWsjq6PNoVT3ua6jSBplPqsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLJt2CDh; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLJt2CDh"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f33ae12f97so4914345eec.1
        for <mptcp@lists.linux.dev>; Thu, 21 May 2026 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779360706; x=1779965506; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcITv1aLmQHZwrYDuxfuNGe0IPwswwZGjg6+RIKbUHY=;
        b=bLJt2CDhcKHy4wx0PuK5QkBL+Wl0uR30wP6Fn/7GNcS0x97qO3+JlhIriKmJlY46c3
         0qjisafiOpzspSednM/k72aZRdXQoAEibMGRWmAZHC4q7aBABhA6taexXFo0ynyRVp0K
         i8YMmpwO2uLb26wCWVUZg6S7tAV/j8aGoS1anKpV1Gf0EDosnkriDN4NMnt3SBSb7IhL
         AjwW8pPs9LDtpBNdR+Nfztx70sh0QUV19IxrzrPf4oBN4Z8dVcuwyOd2XhlE2rgt3xZE
         zLg9FSdLmK5QmLlkhNe7WpLJvYtFvtScRRGz13n5/2I1wimeX9NpAW5IXqpGpVfoSa3D
         aE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360706; x=1779965506;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcITv1aLmQHZwrYDuxfuNGe0IPwswwZGjg6+RIKbUHY=;
        b=TJpO1hpv5vHPSwlqrmWPXTOSNPJMLuje1eSTT4fdhETJrAULo2zejlVEizNwZQiakl
         xRFViRfFjLH4++FCsFWK7r5B2iJu5CRy+v423CM85aZCM+ZQ1kNSFtdrGAvLbyfILepk
         CDYNp5SZvbyUt6PueDkSAYPIFWsIn4SsYBASm9IJaS9bnUFD5lNOK3cc+3sQr2sKAqDv
         sByz10XwVm1dvK6kiA/LFMY4pbH+JNujp9mMVqKnxq1LOBoG2PSWxqcgrVeuDejT1k3L
         ncWLpHaMjmB0nF7+7udgx8LEH9yvvxOTNIMtOM3/tmT62BVJYNO43tEPsNTY+3qvYhQ6
         0XQA==
X-Gm-Message-State: AOJu0YxGoKaGby8KISIH94Mh+QCNU5A9d0eUyQXcmtcPCfoh6ZpsLtLl
	Ev+WvULBdav80coPjOjLyva/zvoPetsSsNuriIjqXZ6dv5Q9KsbGsM+kfT+3
X-Gm-Gg: Acq92OHvERuoA8rh9Z0bex+Rw4fCqFrlR81YcMAVGOk2FQK9eVzSoinYT6nqKXbl0vn
	Sshi81kXghVV4b8t09wrGxjiC9Zczabgs+7AKSa8QsP8fRWPpjngIWnDTGBxLiwZeet8APjCBp5
	BKbLWn6GY/FQZCU0RVgPojzu+vWvyr/xZ5zjcfFcIdsO1t9thP8/3Lex3my6hvk63N7fkxRi9OF
	/i+V6opPldzx0PLXn6Sc9UIz4hvgANwjFFIVhS2ETxguaSEmDdzbUAHwUsY2jdzlSsUpTUIbJz1
	Etg6lds5e6u8qL9Uzp0pO6kS5kbCz7A9vXgbVybJfAwtk07qJNJzQ7StG45Ygfl2lNETPHvUSVk
	+b1JHtrtO3VPmVTHtTnaVOnpYnGRf8GrH+LLPJZ+1isOMz07OhUJHf5Fh2IvX21OyXqtd2tt7UK
	FDLMHs0ri0ws7GWg1bVFhmrMB0pXyKwwfS+Q0=
X-Received: by 2002:a05:7300:ef89:b0:304:67:ba1c with SMTP id 5a478bee46e88-3042f43949amr1364895eec.6.1779360705987;
        Thu, 21 May 2026 03:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304432ddfcdsm196473eec.5.2026.05.21.03.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:51:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v19 00/15] MPTCP KTLS support
Message-ID: <ed81da6a-3ef1-5d02-24dd-80e0279eb9ff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 10:51:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/262185=
27078

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c990cc4d2f39
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1098625


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
