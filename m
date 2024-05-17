Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FB12FF6D
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715970532; cv=none; b=WZXUpqjN4aTEmfT6bZIlpRtE2iEO5D+pHCAE+dOb/qVwsT3aB40FApjVvtURa1Z9Gxahcs+2Ks1+DDH02YVn/9Jin0KA1rFcrC+vQqUFOt7M3FSUnNcRPrdIR1Qebl8EfvZbljYqFzyTEvlkm0S4d1eTKrSjpQTNaqCw95BACXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715970532; c=relaxed/simple;
	bh=rYtiioXMHmYavMppBfFS5QiHlYTuq/NUg+9iFS4M2pk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KO4hPG6Hr1EZsxU8gjmpKStFri6TrpM/kuSM3HxeiI6NvDb+gdSb/BJvntDDr/4JE/ien6eozUtY7/QxFgPrIfWvYnYejtyJzt/v45bdKQ0SKlxKfpaPq5ttrTOkMs7zp6lX/40ze3OK1kcQgzqs7fgXMO+9CcoLAXjIl1gfw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhdlttFO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhdlttFO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eca195a7c8so17829665ad.2
        for <mptcp@lists.linux.dev>; Fri, 17 May 2024 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715970530; x=1716575330; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4vEgko1NpmTbp1aeBGmxTveQeSXJUGn5DBHdak8Bi0=;
        b=DhdlttFO57SjXhrtGdBuoPg/9ZGLczDcCa5THLgd/JCorOkPfsm67QoyXnoMF3946z
         vQT/wMokkPAR1gHZ2iU5vdK9Ix9d+o+9fETd63iFkEjvEU9WuxJXoDwoq36YGsb2OkWk
         0o+UcvpSHsaYRxWalnR4IJV+Gm3o/yb2zinoVprnuJBqZ3R8JFU5LNzoeSUTInzLa2X5
         LOwl4MOt9zmoVH5YTkVoVUTxG9qMkiZeAftvTWh/DB7Vldp7RCnHsOVqGf68drJEwGYc
         iKklChUsD3gOoJmNSFWNpC0y8gI6QcV0vodZdd+tLKnICYnzHo/a5xe4yV03lSRkL6PG
         Somg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715970530; x=1716575330;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4vEgko1NpmTbp1aeBGmxTveQeSXJUGn5DBHdak8Bi0=;
        b=VxhKiugb9mC1cnVbRUs28+i8d/hd8WBZB++yYPYbNE/qinKbnhzIEFQmlXeDKW5fA7
         +eai+cZKajr7+ASHbhrnejqr5yflc7ripuR3TsrsaLHHRih66D8g0ckWCNFj2yTocRN1
         aA8OB6EGynCHEJWHbuXJyBM1kMrVFhvHpq7HXHtsVXAZ9jJ/C04/yM73KdF/HsomBPaz
         PhrxF/MxprBAtNqC44KW6sKke654wJspB09N86ksxOaQCn9RyKwp2BToAegGcpruzud1
         HdGlgR7pSm1msidU++N7vHE08ZvetVEAjnyUlfdZds2pbwMC2N/cAi8n1Yw/HXHKAIo3
         de1w==
X-Gm-Message-State: AOJu0YzRdRQr2v8Lh1jRQfDdeg9ZwDDQv0X+4j/X3uyWwK8JXFad8c98
	fojC8jV92J+uTrqIWLV5RjLs5t4kysIn1p4HJD2iiSCkG7fa+fA=
X-Google-Smtp-Source: AGHT+IHSh6wZaEUn2/jcDYEZWkccxrFphJOY7rH7oJ8EEfsP/ohDysUYJObi4mc82ias0vnsYDYDcw==
X-Received: by 2002:a17:902:da87:b0:1eb:7334:1228 with SMTP id d9443c01a7336-1ef43c0f666mr305875405ad.3.1715970530117;
        Fri, 17 May 2024 11:28:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.33.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03700esm159558055ad.217.2024.05.17.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 11:28:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
References: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] doc: introduce MPTCP global doc
Message-ID: <7340e627-b26a-cbfd-dbf9-d3fb99ff2b2a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 May 2024 18:28:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9132273070

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8d1e5a53dec8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D854078


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
