Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AC39B969
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051595; cv=none; b=XcnOFcbeIzyoBsNMY9HEgQI74JP/XGPTsHYHAhuSztFnp2BC6qZFlv5yGTwl3tlVvzCfxOTjnO9k2XY0aG240Y0/FfrszZczLClxoFdv3Ws0dJFIzieMGp11Hqi8oBzX0hxlhXkMyC2R3AT6AN3sEsxGMMdcLrT+ym7OQkJHBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051595; c=relaxed/simple;
	bh=AR3dup5Mmi6WqgHvsq1BSdWx+oTJBng0Jo9hUjLH8W8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Yqa2VbhQrAl2c8D/040JIaFApnvWD9PApyVpKLTxC0QiUcIB5wd6MOPzvpTsJnW9IC7yIv3tqH4ugnqxzqLXE6Rtw7gs3J0AiqO1/8keHpPx1xX/YH+aUwzW1qJkX+hyUsMwm345VAq3LGIGqKpXKI5JpHy27r4UulSq4jD3RyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pP2ygjd/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP2ygjd/"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efbafa1bacso24290136d6.1
        for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787051593; x=1787656393; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jmr/xfXeT55J0din4ldN/vwxasqRm7qB6NxGloAP260=;
        b=pP2ygjd/4oyBxvLjTKWQb3GaVCLAlsapZl7lvOxYX4EH6CKr7h/LiuKsiwmjsJLSHq
         DQNsx3bGxoHD0hGH/ZrO1Qt5NTaqNJ1ItZQJE1CukDP4kcQ4bfJd8yHHRQIZL4+xtOb9
         bO6dXOAWfp4wINSl+35847V5hwUxJAVP4DQ2ZQKS0vQxuWPcpe5jV0HKy3R1VPjazp35
         ttEElf5ef2umWGnHWYxwK5PztMbC5dwofSwqqxvtFrNGZsTYGo8IOMxTOREy0WXevEgU
         a1aVPVoDAcxerRcLMObjb/UxCAmP6d0JmedwpN8HTCpEmqDPrILTU3rIybZvhoNm5bCm
         o3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051593; x=1787656393;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmr/xfXeT55J0din4ldN/vwxasqRm7qB6NxGloAP260=;
        b=f6XYqy/0e/dwwY4l49lKMrgCyGOwi/n9niaYo2e/FwydHA5N/Z6DF+k388TjiV29Al
         MKp3ETQ4UfNcJVl7EbyV6Fut1aMSUnDYEmqMOfQOOXRqJ57t/SAAnC0OyrkyzOqmd90x
         LG7q/up9x5t38i1kSk5S1wRJrRQ6sSlexqElbFbt0JhPD793lJ1vXpMgntZgW78okvrE
         JOaBDpqXuoVjXEfbpQ1+A5T1p8Jt2By4e+KD8oRAPmTDNFILnx0N6SbN7YrmX0IugfZ2
         8GC8myPCCnldW2ld3VBHitQ0pcDrVnDrQC4zCSKNIAChYMyTc4enz8og0Mfs2kziA2kL
         NPDQ==
X-Gm-Message-State: AOJu0YzDq5x7KNxlmRKwUPMKNMIuSqHuE6MOZsMUIFMJHw++IEPYpLRE
	8KGHBmJqwRVOG/04EX5IbDouLSG3rzOg+mMve71AFzrL1epeW2bO7/8ZRXtt
X-Gm-Gg: AR+sD13X99cU+3OZtrqbPzsXEK7gFWo6PD1KsN18JDEoSoj8x6YJByrn7LYVDPnCPNB
	caOQQo95FMDEnd4Fk2AeQOxxNxJsm3ZFakqmuNySNX6R7t/AX7XVDSoF2wkJsSh3lX66bgDEz13
	8AkfxemFgmBZKlKGMwAOzCZry7dtLBcbaGi2O09ZQ9k80Guwi7GLU68V84Jl4Q4lL+3EIs85vRI
	EiwrYCz0zw+TceB0kZ6nTyIKfeol0/MvqL1d43WEwQBAcy0EHXysFj8hBKb5q1LxZ1mF9HikOS2
	+feAgkOmCNBAEKlhFPNiWwJX8oafnrJTOfBZb0XIJ2j8v/I3rhq5o9zSAFh10CjZTEf+jpeTsOj
	P/uI4jotFbE23U3JikOkhNwXOSFIopMEINlh2bJe+BACm4YH1MyHLgX8NNoF5KHc8DC9jufn+cp
	JRO3lb/kRVT2I695To/nJSu/UD/YJGfGmrkD4PG2Wr4x+B6EZQ2M2j7768RJ2qQxYIRzqrlS5wW
	A==
X-Received: by 2002:a05:6214:2601:b0:8f2:1d56:3e8c with SMTP id 6a1803df08f44-90a91dcd59amr341167356d6.29.1787051592941;
        Tue, 18 Aug 2026 04:13:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.154])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4597bbf4sm29572156d6.45.2026.08.18.04.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:13:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260818094825.48446-1-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v2 0/5] mptcp: avoid data-races around the
 sysctls
Message-ID: <67c73cf6-1454-2d0d-112f-fb147e65cd30@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 11:13:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/321267=
17530

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/544bd110ebfb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1147698


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
