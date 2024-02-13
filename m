Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1B5DF3A
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839367; cv=none; b=tDmklqQORia4x5tWHvgXH1WE2Vge8vJ+6mIld0BGt5zHCyUjSXh+YzgfNjaamkSx5bQt5U4XwQvPRFCCCVsYfA3UWJTSKE0RQULQKxhg2d5PknNbOl2KBn8Fp92Z5VIOLn8g1+9+KBLECHG3RbSIAN25U91lRyZJzBG2RZUlzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839367; c=relaxed/simple;
	bh=Q0EbyGss7CQk4Mr19HE5/UWhV1mw+RK05esmn254I24=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=e7Hwu3iqw9Cv8Xzjoy7FuT5i54HJ9VG0ErJbiBwHSMX8MMSVsNz3y9KOpo6ZqmlklK3oiPt48CsP3UF53UeqGERC/8cZ/9kRnPff0m9iwojGdAmnryKvsqsUwdJevShGzGRtYnXMT2n1xXWt70fM/7CiD4Dx6r0DcPMendI3F2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuM1nf54; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuM1nf54"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-206689895bfso3191852fac.1
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839365; x=1708444165; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2b9UD1fw0qpgPr7FygGeMiFTLiSEPjagIYL3psyouU=;
        b=JuM1nf54g2NsZxtne507qJW73wRueiMEAPFTuehsFdkxVMv4Ke2HFq55fiJqKpfutC
         /Nf0qywGk7fJk6gNTvYs6T7lfVv5umDowtR2v69b48GfLjLFMtZodqLyJBQpkU5hLYOu
         ndwuOtaV4B2eMyC5x+HIDiONE06/NCIdBb62JMWypJSZLQIlie621F003m+O4ooYNI+2
         V1Nyeds1P0e67sb5TJ0+kXwCOHjL8iKrLSz3GoTikxQLSlOFXDstST9MsQkbS6e7cIkK
         /5jqZPHardsdb8HJuWSuZ6AQB/kx6vQQy9ezdkgS/ZGMJRRrvH2aeoHIasxYOA01yYVr
         Txdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839365; x=1708444165;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2b9UD1fw0qpgPr7FygGeMiFTLiSEPjagIYL3psyouU=;
        b=jjzHT2AVWDR+ystjHJoyqWLA/Eept2vcwXcC9MsiqKQAOjhmwp/xCrpf+LwJf0LtKe
         RtimuWKBZyuX0DrRKlM0XGVjsCaMXA7OQJEMxBuPPqca4OyMY6/2ZF5T4z6L4jioOPv8
         ZXPzSkPnHTME8kLnwaWPNKV6kfoPi085639cxyIHE74gZ+rnUwn6sVM4M0qYWUXuHJiJ
         Kbu09L8IM8Kh6ZMbg9203OKfDTJh4up5GCW8MDkYV0jGJFHa4R0pmyce6+fshZaUkf69
         fkb3Jpm2d7G1yiNK0tsbI++DUdZjZhBJ34CL1CmDvmuIrAbALuh2f/HZJug4s+0FQmQn
         hCZA==
X-Gm-Message-State: AOJu0YwPWXOLCIZZedKkhpjg7Gh7i/oH5DUSn990yhFNMC83txjhbHMv
	LxuoolIqDRVGOmHfesmmBe7lR5PPtrblGiPBZ4jNvwfHAz3VvWE=
X-Google-Smtp-Source: AGHT+IGavoN4f8z1ZcYmB0kGNwQvlfRXSckfIj4n7MIsvM4F6NoBdabkZDBNsKjMQXpxEkiUCPGKuA==
X-Received: by 2002:a05:6870:c10c:b0:219:84b8:40d1 with SMTP id f12-20020a056870c10c00b0021984b840d1mr9958963oad.20.1707839364794;
        Tue, 13 Feb 2024 07:49:24 -0800 (PST)
Received: from [127.0.0.1] ([20.49.63.245])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a144e00b007859d64f76bsm3039565qkl.113.2024.02.13.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:49:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
References:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
Subject: Re: selftests: mptcp: diag: fix bash warnings on older kernels:
 Tests Results
Message-ID: <98da510f-af8a-bb05-bc65-5ada20b4a0b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 15:49:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5220473605193728
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5220473605193728/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6152222736646144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6152222736646144/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a0e162ea2e56


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
