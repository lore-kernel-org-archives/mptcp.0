Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170668;
	b=wGVpbiayjhJEE8tz/d1en9QS5aY0MG7Vo77Z+IOCMwgrw4V9baPfLg1ocGdNKb6KPzBs
	 b3XdXqUSTfCCY5S8Hs7wYu3F812Kje/MlNQSnK9givdf6QyPX/s2SYEc3fr5zH2XCenr+
	 xMebdcsfA/K7dl7n1x6EfvCoKWx7ti6XZCcLnMR3luqGaE0a3HEc0gmUC3Y6HApfG3yxT
	 BitO9NKMzRUw9XRDErxkdUliGLvy2MM0hTG+3PHBBdGgqgeyWuB/flYXfypJn8eVbp0sZ
	 5atazkZsqUvfJguOtuXy072id+enGHT+ciIk/hDA5Il6pjE6QQHwSA9m7ymFT8rX91g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Q7MOIcl6HJwekgaafbo8OJLUJGDoR3pW8fhg5Bc/hdA=;
	b=zkXfQ1ZFPjPet1rnCb5DQTSq711rrXawqkEc5FYNPxPXomS66E71H7qecLzCBNlPaOIS
	 uHJIdhtUI0FMcHF61bKG++Y3zddK2dPEsAkQCg8E0Vfeygg1ymWvoe+WrRB05ZglB5TPI
	 4twwP0KpVQdV9LuKPgIlzjWYGr17TF7vo438EUi4CzGvDSQLClvpsG0f3+4xKgwEMMhTT
	 tYFrCzzmB4Wh+cJ9pr2M58/8HjH+WT9RdhRPBJfe9MyLXEyqCCz41aLSzzp/7CTE1xulF
	 Z7/8agd29ZSxrX3s5FcMqKa03mZhtEJcVq52DKJlXBVYwKgdTs6GNWcfUq6QPZnp7dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpQA5S2z;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591D606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 06:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B591D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpQA5S2z
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so1262902eec.1
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793170667; x=1793775467; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q7MOIcl6HJwekgaafbo8OJLUJGDoR3pW8fhg5Bc/hdA=;
        b=WpQA5S2z83BAc5OQrvisrRvwyd+9va6jOhK5huraLd20fUWG5sjbHkJ6fmy63GI+g6
         S9uZSQ7Lv01YUWn7Vq9lQOvTJBm48Zc1BUJjP4Zr2kDgyNIaotJTSOOEf6nArjVSWtP/
         qRARN71bh2PLUMrWJZ/yNlzCK8NZN9EpdWOjKV35VuzlYwCfcGH7KFvqOwmTqgR1slwN
         pP3kXWgW3VP6743vBCw8LzgxN5C3zon6dPbbbU9sMRBwlsWgL1UPSCf9VbJqLMeH7aMU
         iIQB05ft9Vt3P8NCj4gSDkpoGHHr9vkqBSvDesSOs9SK+12n/WFkgDHHGKKXnbpLH2Vd
         X2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793170667; x=1793775467;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7MOIcl6HJwekgaafbo8OJLUJGDoR3pW8fhg5Bc/hdA=;
        b=GnfHRaIsAK25HgflWA1dB7e6yNuPQETN3BIEvKwVgTEPv9+ocRCIUdmUf30OpS2syp
         nVbg6QJjTHeOHyejE2eeN4Q5VCiwK7951X8sUBm14pSYX32cKurAFngRZcGMP05tyFlv
         e2o7kpBDMTxNZjh5Mtykbtme8riRnxW+5Bc+oDTV4Xf3v9nGDsAksviSpwG9BCP8RXax
         rlkpw3a8LNBt57riVbnkq2v+1E1OIYRq/dvLqaOa8xdpKegVGuzszKR8X8kN5NsroJ4P
         4UMluM8tOcZPV6deI/zfITH6OOFJzpdfFj80LwPtxuGvjTrwPxformWiSN5tjByy7X+B
         f0Rg==
X-Gm-Message-State: AFq9FYLNYP4nPyz7OhZ1evGeQ0ecPjXI4JgaH8jSOBW3XAhSn7aYShII
	q28wy72AeeOMtc+zd6hJXM7Wb6DrfVwrV2VO+bF5Kx4ckh6odf0spGo=
X-Gm-Gg: AYBFou3BWlNydQqKR3XsZCrmoPilNTUXpZMK8EjzT4TuiJmISoPQDDNfg4SMizdJ2ut
	qJrnC+wpQ6FTPeUFHr1NZMJWdTnCmNI+45iyBZrLyDhZgMiCtTo5VRS1Kbh11xe1qVlKwTVGHyl
	DFsUUBP4ZYf8XoT3fI1LyppxLy2Qb/qpDMmPPremLTO+s54+TZGpff6YIFfsJHWBrk6kt9ewY0B
	Y5PtPUnwXLzzJQY4EA1XCEOp457y27tmzWCJLhs/Y5I99zL9hIcFMbkzEEkaWxhwY1gZ7CHC8tc
	yFcF8chBCp/SAZvyzczH6mZ2NeASTd1wu0kCN02xH4oUnxn5Lxad0Liwj408wwJu+yKcpT4Y1ZH
	OfCduI7NqQiEnjj1LRkg/1KL7YBs7iMQiH5kvNr17B7TSQ82Wj7Nmik3leeMrUuXqlVcQbjOoKM
	Ox7dujAj5X1f5UPHU5grA+/7EKN2V2p4tzi6nmxK5OKvjbn+IWfmcdVL/ARsnuH4kG1aHXqK2TG
	PhBr+TAKGmZv8U86eS2/XfE8myXCWPIiGe255EXn8B4Blh9zNXSmCowQkPZYQkMXh4XRWyZ9u4U
	NFO0fhsWCDqfxsBkT7sbwKh7hIN365JSSgSlohg2
X-Received: by 2002:a05:7301:b09:b0:360:d4c5:7243 with SMTP id 5a478bee46e88-36a2002d2cfmr2152821eec.11.1793170666613;
        Tue, 27 Oct 2026 23:57:46 -0700 (PDT)
Received: from github.com ([20.171.37.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm5155574eec.23.2026.10.27.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:57:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v12 0/6] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <0060a073-0428-96a2-d82c-15d4f3d9b4fc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 06:57:45 +0000
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

Hi Anil,

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
et-next/actions/runs/40640831760

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/9507620eda=
0b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195165


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
