Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FD3314CE
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604781; cv=none; b=hQMl5GCUyGboAnJwTGaCj/kgemMtKvlvxgGc+qEuZu/d+sTs73lHrhYnNHj/h+8obSSf2Wb4sSOnDNSeFRaDt0qEoycE3dCSlFWh4+HOnDImxNfmWkaQnP0y0g5+CgGlkQodLQmMJPgbVSxnPPxbOBFZZvcOYVOUeFIrN5Lv3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604781; c=relaxed/simple;
	bh=JYjp/gkbs+DERma6dyoH1B56BCuNItDw5qNMlfCbp/E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pyqdBMDJc8EBcbYpl5IveGElEc6k19sOn2h1xNEP49FqUFZMfj275HuvNkS+d9WUVIRXqcqtKuCamknTmYnQOWTcZtfL69grT6D18TgA9TtWKWuPEx2kkJPNpP5A8PvW0vo70zDU52ZzofR+cS1P4ZxKQ5ElHc7E/MasT88vx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6o/1cGb; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6o/1cGb"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88432ccd787so328503239f.0
        for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755604776; x=1756209576; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqoBnhEr+UW6hcAgZ9Xjrpf9jCs451a7rRrif67j4mc=;
        b=L6o/1cGbyAdGQ1IFUQNrp55gGTHRi8CxqCnAvaQl52j3PlSmHbWmYtM4Z0PogguHDf
         I4pQbRhPTda1Iep2A5OUHUoOE60zzDHCFJYDDerhxg5sqWPOCnkRuSCtBq0rgN37W+hO
         hvU0XySZVUomfTbeTj+fhXKMwdQjF7NnfoOm2VzICdEDkCgFdL1jHY+ChtOWYHZFBovc
         K5p0e58UyfhDcnuG0CKiH6K5YbWFBLx2xNLg6lK+wHs6F5b6IB9QiLUnA1gVbFsqH9kE
         YoZ3m9GAspgaOB7F1Q88zHOlGzUKuSz4oc/nKfCsf1E+G0+JUE2mffK3DAfZi/hyh001
         1mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604776; x=1756209576;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqoBnhEr+UW6hcAgZ9Xjrpf9jCs451a7rRrif67j4mc=;
        b=AzhOvKp3tljr5wsuoyMc95wwtQk9QzpZMOIsKvG0TnkFqjd/cNUjV1Up6yIfqUm1bi
         VuwOjetuXvkIfPMeveWyz+fXcTp/cp7RW/blvx2mFn93JNkbGt1HHJuUGVfQSlHsxTAB
         tRZQBtPwHYjyf4fWPWdxf/xuSIFVbz9m56lX8RhY8umTMKXZmgqSSzaD3Sio7Q2KbMeb
         1eSeDKeRTg8/4C8Rqw4iUwYZwmC2JPWH3jK40p2NOUu0mw0XxYEK/WYZCIPhRpbyFmG7
         u7otbmQgXHKWvjusq5D7oICal20Bf/l0qqr0FHwMYjjKR5Y68MgholjHSBx/P23Ep0xM
         jD6A==
X-Gm-Message-State: AOJu0Yw+0sTcx9GhS4PYp34MLJ99rv+LfRnrDLGsXXDZVdEYWYt3u0Q9
	hoI/pQl+X6uSGs4WeqTiHGIQOIbE/9SQ5KRrcrEz48bAlmKdtXdgWkaH+LajsA0=
X-Gm-Gg: ASbGncuQHlgMEGhckXtgKm/ADgRlvQ5mBVqJR8xX0I/mKKB/YMSgxdA+mev5dJ26ID5
	0b6PaqBwjHft8Wp+dEnM+pCCltW+/hvgoYHmhRiqBtWoK6CEZeeZ4w8uCqffzwOyYkapuVII2tI
	eO80JwEIBJf09LNxvYfv4bnjoksrqG3NL0Sw5+9BeMUqLjjOoA1bpxnsKafepcSfnhf+auspWlF
	+D32h4VSvnkr95Ff5kcWZ2ICzKjBTTi+24vl+GH2OKA/DpcaNWrqJGAmoe+YBYD5LVGjjfb+rc8
	sP6lkmzyzhsXwrFNfaJ6U/zGAOIcWUijbq/Y4HCkiKQ1oaWuJbFIvbm+EecgpwC9THNaNbiTk0g
	43+k/2mNolRZEnHYJCxZ9+FIqvjVH/VhoLFRzXkV3OuDOc3o=
X-Google-Smtp-Source: AGHT+IEPvsFJG/IyJP54NpulIj5SMJHsT+mQsMFF9lSoOka+a6ujkFUEkYNcK2ImqBjoYlK0brKifw==
X-Received: by 2002:a05:6602:6424:b0:87c:34e3:1790 with SMTP id ca18e2360f4ac-88467e825aamr366230539f.1.1755604776559;
        Tue, 19 Aug 2025 04:59:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.243.103])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9f6d8dsm398692039f.24.2025.08.19.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:59:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1755592822.git.tanggeliang@kylinos.cn>
References: <cover.1755592822.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 00/11] selftests: cover more MPTCP socket
 options
Message-ID: <0a46dddb-5e73-9cde-7859-9f89048a19bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Aug 2025 11:59:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 2 failed test(s): =
selftest_mptcp_connect selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: debug: Unstable: 4 failed test(s): packetdrill_add_addr =
selftest_mptcp_connect selftest_mptcp_connect_checksum selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17065050678

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/105b3cd0ba10
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D992927


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
