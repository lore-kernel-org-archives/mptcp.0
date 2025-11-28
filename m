Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08D2E62B3
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327488; cv=none; b=BOI8btCOmWYLD8RVJq61Y8HcSvKEmav/1YssiGOhRDAgyP62BvipOFxWf1359MRr5pPB4iHRlXEQR7QuMRXj4CqSEUVlKjTg1DpDHRXfYWWQ1OXBF2+LAPlcgJtfCse6xE/FwkoqpLGb3bcpT7UkOA40/+XhBrfwTsDYuo5mHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327488; c=relaxed/simple;
	bh=HKCE+26thzP63u1C4IzfwG/84sM8rUq3+ExdGWAMvjQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NyntMd8bNRz4dJSYwRRkHJigToyoJj0SIKFmGsssLlPa91CCCXeI4iKfFsxOFmp/xXcj3XOhSFBmXBHTJLVwTyfqpvxdLyuku44LA4rl1b42V4kySmPIO/Am7L56eScRJzO4q9+4MDnAbzB2+XHznugY2CoFLH30J04/0KnB5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/sT41jC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/sT41jC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29555415c5fso21269075ad.1
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764327486; x=1764932286; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IljqjPX9oZXmHXwge2EO8AjUE4jgOo6Ov07+t9JIq+I=;
        b=i/sT41jCipD3ucAGTRm8BXPTUXsxOykzorKW3/kWLJKHuABZymrTnIapKwLghy/Zd+
         JQ0MW4hEPBPD00DqsvDylysHqb8S9JEFSSfpWiyochZsLcXhCftZYbW37BS47CrnSU08
         diJ/PfzWhOv0mrTPGM7HUTx+GTvr/VOhYvN1KxDkMmlUXg88KTsdDxFzfbOpakSW5DDT
         I6g8qgJb6CFLCwtXfx9KfAfXbk3ekdRolJf0Pb0o6Io++miv2g59ab0SbNGUBG5debjQ
         ITeUZpOXB6Tb7iBLN0fgB+QblVs2fD5e+/WdDMQe2lIZEn5vp0zoJW/XuKB7LLqnyqOP
         unvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764327486; x=1764932286;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IljqjPX9oZXmHXwge2EO8AjUE4jgOo6Ov07+t9JIq+I=;
        b=k+wJmMH9pLnrPlbsaPjsnR3d3iEFJWf03vTzM2vKRUTjij3aNhPwo9UwKv8fi3bAEn
         7WivoessIUw7w3CKwMwrV1ff0eFcItJ/LWZA5mVBbHdK8R9hCbGUXoDZcJbrSNdhxibA
         MWLCs4z3EAG5J2LoekTWOL1FdI3Syxi4xzNPVy5t+v07jdBS0AgdBkI17WUkZhZCv/ec
         Lf2vsWQ9zVtD2g9KFfPrYqXPPJSyzxpmp6ZoVKoRPwuxMs8EINflCX+LEk/zb+1Y4qMe
         KOFvu404+FmkyxC+DnQusbMck0P2eNuMXDJrYe1Mnz2fRlnQs+NL4ZJ8dorVXqcymMRb
         PQgg==
X-Gm-Message-State: AOJu0YyFKZth1v/JwvT6I3t00ok7Hi23EobjcYu9EDB/WhbzuyJTdsG6
	7XR74MbW4v6eo+4A4Oa82EL9XBZMHodzPbwNz6ZTdFp14QRitL7mWuOUdhby
X-Gm-Gg: ASbGncvQx73YE7LDRx8lUlHjg2XANu4nX1jBVCyyJWC44EXY+lto0xYTnGa1KJ5eZwp
	LhLXfzlUeIbfQ3l6UJoh/zYEE9y7NgBHHpiuOJjR3Ac+n9E8XtmVBg35t2NNBXm57skmj2wMxYM
	I1cwTGNXUP7MN3WC+qWMT1rbXQzfeAIays4EtV0MlQMaTB1DQD6FjmdNVSBcb8Pq4cNyA/Zl2CQ
	WW6sYocYQIKQGk4A8G6ghLiyF6QBSxFrTcLdL3oRqmVq6/OL0yCcVo1acbDr1mlIfzFh7D9PpA7
	6hT3+yw/2ti0aWSCW64MOhStgkmX4oyn/Jt0QtosrhqPygOc1NJITPa5Np6KMozTKY3y61RcOp+
	KDgxIG3s6/urJMtQLpqVHL8Eqcl1/dS2MzBNKV48QSyBBJOAkrLOepkeMaWll/tivpgehOuHKAi
	YfJA3NeE4i1d8fK/5ZtYEBiYip
X-Google-Smtp-Source: AGHT+IF7ZHVFXTAJlN2ooVonHjLdbSuiVvQQlxTsnIq3+j2YXYppmvhv8Q0lV57IpDMczk72S56ELw==
X-Received: by 2002:a05:7022:60f:b0:11b:ceee:a49f with SMTP id a92af1059eb24-11c9d60d675mr19434744c88.8.1764327486298;
        Fri, 28 Nov 2025 02:58:06 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm17533944c88.0.2025.11.28.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 02:58:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251128094417.14463-1-gang.yan@linux.dev>
References: <20251128094417.14463-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
Message-ID: <00ee6127-75db-8dd3-8d92-513e89c39274@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Nov 2025 10:58:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19760550380

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/793ebeaae843
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1028603


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
