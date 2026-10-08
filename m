Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839A46DFF6
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460772; cv=none; b=BofQ17+tcTOFqGV210VYRV09PXYx29+hD4axUh/wMQ3vKy0EulDtLKeSMEG+qNQ/FcKu8AahAHKKBr/OZIA8XI6oA8CmRB+q9hTBzO/O8SNkxvToNkiX5eL3BnohqiKA2AyASYeNDi6fQzoSrgN+XjsXPm+LQp5AFPt0i/kFaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460772; c=relaxed/simple;
	bh=T1zxvKrfJWgHR+wLlu8PlklQOVrhW1zarVcfXB3PPHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mBQ61yhSTbZTAn1y8rPcnNDtmZ8eXV1324i7DihzkNnQKlhJAYXCLsZ9dQDZDYwrx7JQz1MLwc/uFhoaNUPiIVyICRFCHkkTDZbNTvIDSpcIvjFh9oBkarNZI3qU7NCQNC+ymowCfrjowhXsm7Ou4b5km5wjYiqWAr8U+0NwlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7UIbCNw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7UIbCNw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e4f0d7d77so423424785a.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791460770; x=1792065570; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Km2rEMu9V8W3eWm3XgMisWe0+6jLJeRj0oqO4XEOcPg=;
        b=i7UIbCNwgZkVHMW+pT9eXhj+CUsDL7rgCcNcArQJObGfM4NlMZW9IK5O6mgvvPZ2Qv
         cnfHqYE4rufaXhJqdwKoesRYBoYA+kVvpXnYsaapvPtk8frf0ACJv9fV8QKn/3sqTz5E
         8acZhMp9gNeSWApdLn2/G0QiMQQ3jMmHUUjvCGQbhdfXREBGqAgTFJyeiMCbHRo3RQZC
         C2cFLNTU1cBAolG6hTppqDUXKZkTNCftTtoopFmwCTZC5OTz8/Gz6/shQkH1uPEKv8+M
         Tv+UzoVgBj5423AIforEIF3Sel1p+0Ra37Ugm1t7xnpMU5YzwY0KeewZF6Ni4VdFU4tt
         eQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460770; x=1792065570;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Km2rEMu9V8W3eWm3XgMisWe0+6jLJeRj0oqO4XEOcPg=;
        b=NtwbQUQZ344cLihBts4X51QcwcWoIwXlteBcrgt1C38hZhXY0NRIaa6COZO2MExxQF
         5OV2oB9vXZK7M645xHGK1GzQ1C+j0URYnzOCDxRe6fZvSwHrYa68j0GhZl/qbNzoRmFp
         mrm3ufpS3/PmuU0niZHczs7zwcqDsHs/Ad/M5bQMRhJJuJ8YE47kCrBbHusR7Va0m5JK
         cXZRdJo+WDL0yeYsXNcbZuo/HzKEu9Cf4La/4IBlG+BcwITwKLmTh1+RKcOSD2FAppmN
         XaLY6e+fzINCbi9U5/Qph0e923VZpBdPflDIC3pgtX1fLdQ8zMewlhYzzthdcnfml1lX
         1rGw==
X-Gm-Message-State: AFuF++m1JeYi8XQ/ichjK7pqIBLB+vpPeEo8q5DxXdVUvD7LMpNAgrBM
	qJoGWatq+I0Hj/fGIqa9MEnV215uxnC62lZl6FtjW2Tj2xrp/rZV5ORcZR8ByEQ=
X-Gm-Gg: AYBFou3wfc3x8VV4DeMKPMprRRJRYjKyeAp62JK3lDp9grvU35GC+ZCiuMIBWD5J7EF
	rL1Rj2ZekusRxHPKcWfdZpx/FDTEtt4sbEeQGd9/frllm08eEJi8dNhlw7WrEHRt7Po7YBoveee
	UktWuiOHGD0RmxxMZ7bENV8DtI1U1orvH/4srxH0Pj8rm/SGYZY2z1zvufJPGPF7X7oOS07HMi0
	9+qWRSgcBW9Hi+eeKY3J2SHbDeyJtAdWmNXbZD5vv0u25QReLrnMOTP0iTySk/wxz7qfo2Ih/6j
	B7OeNpIVttRD4igNMrdBHTKR4P14Sss+JVDvTx5xuWXTa7sR4OkD0JsGgDheMdnOXlqfBlle7X5
	MQKvj/d7cam1ce5W3KT2zK5C4dOOH636pl35Veeihg265aC8Hbr6CfVsIfAfB90guaaqbdVdef8
	5TschCBJeWhciAgZpXtJgsgcJGTJVYuVh1hDvVjcS0sSOPp68+0KpvGTsXlnL9ERRqtPOFfjKo/
	jyeiXl8wxxrcw==
X-Received: by 2002:a05:620a:6011:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eaae77b61mr390704285a.10.1791460769722;
        Thu, 08 Oct 2026 04:59:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.61.217])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e98da8aeasm462120685a.0.2026.10.08.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:59:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008104840.131986-1-rameshkumar.t@phytecembedded.in>
References: <20261008104840.131986-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH v3] mptcp: push queued data on passive TFO subflows
 becoming established
Message-ID: <b6813394-1b41-1870-8d39-cc01080874bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:59:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37768511893

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/84ff566897=
ad
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181558


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
