Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D16470100
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621275; cv=none; b=RxcMJMmhhAA++V7Ygtypnrk2eCH9RUSgtmKVpfcNYNg52i+3BfZQlfyQksMaglYs22DpUePRag2Og3OnRdm4KtXR3v+Ck5cJk5GHzV6IdHRMeFeFCkT9UzPXOp8LQIdw/83nid3o8aAq5e2+sRiQrY3oyqPUTERcsZDfWclhpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621275; c=relaxed/simple;
	bh=hrbpVviD8L2hg9wJU7BdVdaHs3SNO54N/5cswWpP6cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZMhU89GKpEtZosYeOqSI+WaYWT3FOsUQTW4sn+OQjoBOr7xdLREF6ci21bvok5tw7JkRPx4vE+0zzYKrXfe8x41tOq0hsW2ULYsmt+7J1s0q0YSbM+IF4pXrVjWBkiO1xThx7edwoH8ULK4TCA5Uq+4uxZTp94yEmO6fj8gjXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Paq+P/Sn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Paq+P/Sn"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930f618435cso28581685a.3
        for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786621271; x=1787226071; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jiPePvhFwb/7ivGWz6tcb+MysU+zHeKuabHOrGPLpjo=;
        b=Paq+P/SnBRYooyICWR5Z0h7Xs2E7bUEVdogCham+hG0d4/yGjUgcLQMRZISwX77Mp2
         hHJnMMra7LL8QdzDVB/am5uO9XSeKhs4+s4eUBFAn3ukMLDybRcJMjXr3vuSb0zogaEg
         3Cz2TMD6gWfnPNV6dNBHRFi//ptEkFOTW97pIiM2A/ssnQ7wUSEs0gEZqGb0FzuwNCWq
         SaMxSV9brYGTlQK4hAT+mfVYyX/1yfJi2A1TKexv1Tpfr9YRlUkBPcrFA6es91JlOTUC
         J/0cUBxDJzeB8y3Cqc8nPPfFm8Eg3opgaatGWtXFzICstvIDjCGWSQcQVzYqEuySKQxr
         sa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786621271; x=1787226071;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiPePvhFwb/7ivGWz6tcb+MysU+zHeKuabHOrGPLpjo=;
        b=cX1A4MMQnrfQjZ3+JimkQW1NVgeQFB80JOV9IVLcwIzXu691bmicyu76wUwkKGojGf
         oY1GrttQLnQqyud4q+oXgjJ48J54tu7mmAqzqM3QmZLDe3snbbwUz7LLMtFl/gNvWZUe
         QawmOaGd3p6yWxV6vbpojiZxUU9cL1eR0CGn/EL/FJ7xGbB+PGi/x6MzP5gFFYvOj1nJ
         ZYreUU7mdAaUW4/0zyYgdTY8HzlN+fJ+vhOJdjcV27KVLU2nuvFMSh37QYzdVuctkWAU
         NJ+L+Tr0bZ26Zgt4YQ+3bVlJeLT1No2m5ImAxRpSUSIi2QUrB9d8S9UirPPs6TaxdhJO
         BqiQ==
X-Gm-Message-State: AOJu0YylG0Z3PeOBNzzdTHgstQkozu42DWSLn7+Y830/1HRkPimieKCt
	e97wOJV3biTGqIc9EGS64yP0bTwSE7WP371u9FllXBXIJjKJxZPaT4A=
X-Gm-Gg: AR+sD10vo5VdWiQil+yrFmdwblSFCrqB3FfyXz5hdjNGe+VzpnhRSwrv9tTp4z/19iO
	I8G95JT2jqG5l+LoUjaNWX52FF0O57SNYTcBRJ1p1dbIuCQAPngnnfmgexoJ2nlXMhLjDMq8eZT
	BwxFyDjZbu0jpJBTaH+i5/HqR1U+fTaNF3fbR8pQj+tTZofMzmpwdD2T3zgutPbgZhTseNpH6Ff
	3f8B6+hqtZ3ydW2c1GwlG9P87KalrT2DUIn4NhZXUEjXNMguYGH/Jkx/YRsMXSkkpTUOBFrB/C3
	gemq0VDag+tbAi/Jt1nMyYPRJWvTIE+AOEzmpPSYG8cndbqcSKHFAxWk8chCMFadAcQqsqrzCpG
	Jn3uWZGdWzyYHkdZoVy5LqQSsrr2djXG6eYv9FhavChVAvR3BO7LMnR+t7i+H4JRCb34JFWXPh2
	hfIQAyz3LH6/92GAF67gd1LWb+0DXFlDRCAC34mDhlEIwE2Cf4m/XIJ/L+pMUgjpl0FDCIZfwAh
	4A=
X-Received: by 2002:a05:620a:44d4:b0:936:ad4e:9243 with SMTP id af79cd13be357-936bfad4f7fmr506113785a.40.1786621270866;
        Thu, 13 Aug 2026 04:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.45.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1912b42sm128910585a.3.2026.08.13.04.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:41:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: lib: get MIB counters
 for the right test
Message-ID: <58a6d0bd-e3b2-3258-593d-0e8c14844af1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:41:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/316931=
94883

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1737d20f1a46
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1145356


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
