Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793595814;
	b=AZy5gc7oSaNv1DTdNcx18lA1NwWgb+dvxuk5JyqBOJ2Q6Ojiu0L/8e0xADq6BNbLUVio
	 7mFw+ELPzhmd87cAJ8l8ocFvpUXXvScLanJzUVaN/EOV/6skxeGnz39pQsHazKZOYMD5i
	 pray9HFZE7TqrpdBToukUx/VWMeSuCOgToEZ45CtGpkIrIGr6xa3yGSHvYFPc1lhCzkk6
	 Zm4r1F3I/DS1KnZHgquWxYQTKfevRA6+0EK+IicHlwNI0+zhpal8HQQbHWZPveJm/U3l5
	 SXa3GDbKJYAc75zW3hZmzw+urfuoWq0oAt0eS/L5ONaI5FuFSG6G+ioRLE0oK8ZcvfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793595814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=I5DAwsjyOsD5FS6wBsN8ZvYJUkZRaXVEgWZ+LlLKuCM=;
	b=wGT0odD7cdNYlgo6pWmMI+RJkfwoLe4TbzUpObr9ayceHLCFjmHQ/7ae9j3P4j0nX535
	 o/jsFiQT+LQ2x+cXIU+QLLnluLkajehpZdrnGLWwTmP/fwN6mhhbSi3lA89/oOdxQ8f29
	 Azbstf/2zLkgmANgJV2XhnfDseYySodifMhXJprWdZel2ssN7EcjF9D+GwQCqPaWOMlnw
	 4u4JjPuG/NtEoEEy9nTEM5djpwymYTypwf5tFb9/4cochUPEzKlOKnd7wJBWojc/bu8iG
	 OSl+gF4GqBIEGoLTJcNgl2dLonbORK3Eco7ub6h64uvRFsFIdyeuNVyS6JBwHnb1pVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZG0ZBhM;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11570606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 05:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11570606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZG0ZBhM
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-369f33df08eso5273942eec.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 21:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793595813; x=1794200613; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I5DAwsjyOsD5FS6wBsN8ZvYJUkZRaXVEgWZ+LlLKuCM=;
        b=tZG0ZBhMFWq//5a9KeaC0tusHOfwcdJITSrRnqXlgJJZ+1zM9aU/ubLaLLO8TdTLK5
         rfLIaYuZLF/VcMO8KP8TX0OLUhMZMTfO7a55rzJ/Dg3kb89JeALuu+kTdlJsal8MYU/Y
         B6kRuTnHx7jw0C3rtS6PWcS/jpLlMIEB/XpcfKbbAqDkghpUqCRLI68Vg6umf2ep589W
         A0pmUkQhHkPqtpaKOaxVPfrfXZQhuh2aQe+C3fbrt87lttAlokhcqF/F5FDJuLkiGnVy
         nksZOmrt8Ru9so5SjIfk3guPP1Gwz4rLh6TmEvziFczs2VxM0D4oRjLr6andPlyioAM4
         UbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793595813; x=1794200613;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5DAwsjyOsD5FS6wBsN8ZvYJUkZRaXVEgWZ+LlLKuCM=;
        b=lkg9yn3UyNrQi1iSdlTxEX+jqmt1pBM5/53wGhqRJjDvLpNmWCOZ3WTC+dT+1UTey+
         CM56/cvZFPIq0ufzLwBc0NNDn9UyAahqgIcFD6G+zZFE8kIO2c0peR0uLoO2CtvHFLBs
         O8CKIYmXBFJPARwx/yklY3R2VE117VdMlpOxIWyCqKpBjNo1Vokh3BWHxLCB9IpDuKbf
         9xjHcfhBt7wekrGhggmu4ADKwvYgcgclSVTQ+621MigUg4H4iYAHYvk6PH7EnmB3OtZc
         A1BGETjEcsOFOnJ8qXmFfbMhvdevo+trLsvWDrfFPdsTZ/UzDjjjr6blJHMRnKUa5vkR
         W0xQ==
X-Gm-Message-State: APuU4Z+k+XBJlGYxiPEyzP8NXLbD7fcbL8kKRPPJGn6pD4dgGbZFZQY+
	U/6RDYNYr90OwsND02lcxAoRpexOCwaQbPM7eW3F3NhE2Gg7gsa5Kw2uR0xH
X-Gm-Gg: AYBFou17IsVHze9tf2Dq3cgHbAgg7HU38H93fLDEyMvFGjBMbBOBaP9p9pZx7ndnXdR
	wRyGhiWK8Vrvsrf0sFqNBUfImbP1dC74+WCkEWu5KnQwj1eJCFFBOr/OsIBdqAMeaFcvi8i3d+S
	Y7YXjIIX7k/rMHxE08CFOYV8ie0SYPxUMMg2E0h6BCAmqNuRaRkrMVVsvX+Oaz9W7lblGcYuJec
	8X6Ks6xl1CQLAErQ1FV5vTCXTf81mwjXSsX6RMUkcAeB/+pS6vvkjyyLl66j1HLNfFSoYMtIq8Z
	YWDjr6k1vwnV0eWIBLkaercy4tsTihPcWHWHEtfI9K/awA+Ib6zBS21US+RNZiz8TYfEAjl3F53
	BW+6i05W+QJ90F2BTcZ7iD3LkrIH/EFhxXBjWlEevGOnemkVS5/YL7iiq01x2i5wRUEfCwt05Kv
	XZFFzNyXpaIy7tHkONb1RzgnMW19XzwsZSVR7SDMYn+G9adCO9y0+U54lIkrfe70o55IyaVrCf5
	bTJm5nkBDLDC46kef5ph9RWYTnTuICwd2DI+8khVQXGsfWdppzLxwr6ERwoKrYXoYqUG5s+R666
	ETe0QS6r2TPPaPcm0VDkS/E7S0hlw/q4uwhU8E0H/g==
X-Received: by 2002:a05:693c:895c:20b0:359:ef9:9be3 with SMTP id 5a478bee46e88-36a4236a466mr13611453eec.11.1793595812910;
        Sun, 01 Nov 2026 21:03:32 -0800 (PST)
Received: from github.com ([128.24.161.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm38236788eec.11.2026.11.01.21.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:03:32 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] prepare interfaces for kTLS and
 sockmap support
Message-ID: <43c3b70b-67e9-5d14-7e1d-d769760cfa67@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 05:03:31 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Unstable: 1 failed test(s): =
error:sched-mem-pressure =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/41382640238

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/64955a4259e9
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1198394


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
