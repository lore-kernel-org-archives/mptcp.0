Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0214A90
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547395; cv=none; b=SZNOeWs2tlT86Mp51WzlrARtyuX7vohikU4Ilme0RYNM2jQ8F+0ABqnV3qVtpopSAvmfyODQvITGgnPIY3kJmVupRgmNLnNKXSz70CsicORUVgmx2ckDZJtEXwmuVOGT4NKOpk+27xM/LFLHWbnYKGnlds410z+5a7mAz+JrltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547395; c=relaxed/simple;
	bh=6Xf8o1flVNtjSkIEjwNTHvI5pwqkZw5r/QHLFki7980=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sZXBNyuPjecMv75CbRyiXPuqEtDEpAMe+R7FICEHSP+jwd+i4A7GxldNu7x3kf9DG3tbfzDBbH8lrhuoo5BXfueoXorA4CRPnaF6yfRJXC+R0RPpLQqw2N99DGIkI7Q/QB3xYI7xDcJxDNNdirZQsWImIJVwfgc1kH4kco2YG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+uCziSb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+uCziSb"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45677452159so4883201cf.3
        for <mptcp@lists.linux.dev>; Thu, 05 Sep 2024 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547392; x=1726152192; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bm3QGRMDx3iblMadQ4EpW+3qZfIPxH+t9uUzq3zRFf4=;
        b=X+uCziSbiI32aLO7ycdzPSLAKJGft+SrURBm2pCkg4XvD7nqhMWYOfZ1TJfNfq3iDs
         ny1iZFbEJvJjSccHy4zLJyVnMBkYLoY6KML1naGDdLO147jaz97ti/R882nce1G9PrW5
         lT7cJsZpvm5TyRlp2LQma37jiE2/zib6ffc29OWR0RxVxT6K7wPVLOFQHx1LQ63pN24N
         GeFVsz8VASUnXmXtnEodZgPkCohxURkAD3lDhp0TyyERXST+2b67jJVjE005LerkYYRS
         C2L0Y7KxXU7dWyc6AS4uanSMRdkU+5G1B+FdDDy7g58rlIpA+5GOVquG0lIx3cjxWGNO
         8jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547392; x=1726152192;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bm3QGRMDx3iblMadQ4EpW+3qZfIPxH+t9uUzq3zRFf4=;
        b=C/v+6vW8qnKFU3no7qfC0lXIcBSMIt++4e2rofQL4HfXVgilZFMmK5qMLiGP5s8uXG
         Vmpgh/EHyISGt+VnQp9hE49KYfnQwOyuIeunZWNbjeFAEsEqm1o0x4/ftTrwt3jEJBSR
         nZ5uW/rdy6mKO3q8K5+qXxL01ynFjAremp+XYTqWvMeko+zAs3KIXz8sw7eHuI46Y/dF
         +qSdlszE6FeKCdSUVj8uB/C19+cnMZPK21dU4oWspsT7LoxWGKXR/bhe6zIsDcnRQHFn
         M3X4vrCevh2PX6H4G6sQtbUNOB4wNpTkriACdgfpqVF7g/b6OMsnyMFQr8IT94STcBQE
         4i5Q==
X-Gm-Message-State: AOJu0YwstU5Bk3DwjsS6gZcpwnw8jWLW8Lw4tSAsqPxhOo7oCKeB3Ae6
	Ix+udcMBU/9BbyixjyeAqSVtTiXwzTTktKTPTM1yHs6VVpDRbAdLo7Fl
X-Google-Smtp-Source: AGHT+IE/Q7HMwu+zZ2aUzaR0eCC89cef94QNgBtp4r/uEqc4P++IPRzLIMbyPv15Oa8jNuC1E3IiUg==
X-Received: by 2002:a05:6214:2b97:b0:6c5:20c2:f34d with SMTP id 6a1803df08f44-6c520c2f436mr20118526d6.2.1725547392296;
        Thu, 05 Sep 2024 07:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.191.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520419e5bsm8034496d6.125.2024.09.05.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:43:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn>
References:
 <11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_getsockopt_to_in?=
 =?UTF-8?Q?spect_mptcp_subflow=22?=
Message-ID: <9cfb7d3e-2cdd-2bb4-374e-69734d8a588b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 14:43:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10721992952

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/161221b24879
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887264


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
