Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBE22F0E
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516699; cv=none; b=DY4d2nrGNa6lHuLQWkSEx9QqwuQ5wATv+Kfoy+7DsnDxlkq73OJK5EXXXaNnBeUrjlfZ72JzaMeFx5ba1MaixUhujzfTWGaDJfvNWo3XVv7Lijhi2PmWKw3Y1ELH1N8xNx2owWf4ZKNrhNl53/UZxjeH6BZqZjTo3Q1usAFpyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516699; c=relaxed/simple;
	bh=t2/stBN36YpEL5yRydYRv4pW8trHgZ6rVcWjC2z3rx0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=MD4PGvse8VgOvUezx59rxWZyXYbGk37TahDdcNsKt2S4oO/7xl7o88CXKWhtYRjei8AXsxX6smJnAgMaKussan/kur4MM2aHJAzML1qxLZvW3zX0Rfjd65CIYQIrvY7Fkof4XrEpbmR8iVjAaRgBep8VwZUuQVaIiSmgN3nRhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOb4ZjJe; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOb4ZjJe"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dae7cc31151so8758146276.3
        for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705516697; x=1706121497; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaI0Hw/t6gwKsh44PKii3kwReWx0YupxeOnemSMc5/I=;
        b=MOb4ZjJecK0yHL48AN7AGpnmmv9VwxXWKf9htx3lZkzAw4hgt7HttYI68IDxqubQQm
         jwdtsFTK94TVg1zWE+k8L4ASk1FqDBUwFE7zVhA5l6jkUNCPnup4SvcHBD9SvuWcIRhK
         VZZHU7bvjOBi5Dl/WFwOYy8a4mtj90agqMCWaEOopTbzaJUdIUalkVrP2RhHTG1PSEoT
         Vf0shdu6zqUKDQXhyVQ6uwblGKMUYkCE8U3U7IiKE2mnKlx1xExRRseI5gbc+ySL4btm
         S2OKX/itjNBG3Ofr4jUCMbVmhefEWZ6vCBx4NMPwyPgCxYcI6fzp6sWcyH1lwz5d2d9w
         m4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516697; x=1706121497;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaI0Hw/t6gwKsh44PKii3kwReWx0YupxeOnemSMc5/I=;
        b=EFuNelJe7VAUzNJ8h8YSFGqKrx4zkIowgW8WVCnJ7lGAE/J0HtdltRAPst1jPS3Jma
         1JifDJYfpvo+i6AGZPS983yY8F9/iz0LJS8tzSZK62Dg8lp1+Z3WeFUAbSsN4Wwq2aza
         4V63vQe56BRRARshi0kSK/BDFzAC09APvdwX223J89TcOKRrhEFguz7vEh6iJsF2J/Hu
         0jbvR9UMpOKOaS90YL6yVfomBJKa5fik/gvFbFAl4vjt2cfNsHBnGTBvjE8tpZK8A6/l
         /aICWVQwtaZzGkLFGpUsiyG1u01GWf4e+UlcD68wbTuiD3UzTSLWkmEo/IhcT/LcWbkm
         bLPw==
X-Gm-Message-State: AOJu0YxQrvSr2Z93t08G4/lxyo6XXGyUYBg8Myi2oGGpHqVJCmPlEO3W
	7W4Lb5snHRigOe7p7r3xWQ==
X-Google-Smtp-Source: AGHT+IF/3hhzje8iz+R0sDAyn7ZC1W5WyioYP2yOWG8D/K7R2hUZWqJed1ubw0Wmo3fv/F0q5DoB4A==
X-Received: by 2002:a25:d0c8:0:b0:dc2:209e:376a with SMTP id h191-20020a25d0c8000000b00dc2209e376amr3093039ybg.101.1705516697044;
        Wed, 17 Jan 2024 10:38:17 -0800 (PST)
Received: from [127.0.0.1] ([20.75.94.35])
        by smtp.gmail.com with ESMTPSA id p12-20020a0ce18c000000b00680c50735c6sm5212148qvl.88.2024.01.17.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 10:38:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
References:
 <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
Subject: Re: mptcp: annotate lockless accesses around read-mostly fields:
 Tests Results
Message-ID: <c23be70d-816f-dceb-8bf5-a6ac18628f0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 18:38:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4513139903954944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4513139903954944/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5269944951111680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5269944951111680/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/64d56009713c


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
