Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6F3081B9
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680523; cv=none; b=FokhbkbHSHUdf8BfUPZPOIgAyUgYdOUCemyMO289C/x418V/t9mGN+2zamHdOkf1lWDJZAupJtzl921+3dxEFU4glcSuSdz8VTeZiSYdEhraA46ThrW9OhCgnEjaSAgbjEItMLKCYvTMoJfHhiFG5ZBSd0JP9nlMo8VERvEQ0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680523; c=relaxed/simple;
	bh=/kiE5t8+zsphGP2OefMj0Xm0dPZuyPOqZywzeEfZszo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VEv1RNuaqNibVP3o8vb6vziefhPxx0brxppRv2e2SvWtYUjMPmTVgPYwogHgA3s+QLPf+sGDs2a+GQZ/BdoX4mpY5+72JWJmFoN3Q4dlETihlNhcX0k9JcRJGvWwKFJdiqDoSwYfan7uiyuw61mzIysp9X3iv95DizHdc+y5+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qez3U1El; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qez3U1El"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1586246b3a.3
        for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763680521; x=1764285321; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anDCDfLB7KrkCqizhv6y9TBanhp1R+JWCM6vVAr0bX4=;
        b=Qez3U1El1YXoCHG1Zh57SnlZqmTjF7dtfW+Y53fQYGIKY9BivX44bbWX0qTuUsbkWc
         X6A/6ne8fqRLPImohE0efMQ3G1pS6g1qrGPYSkSY2bRA4urqKh5+orLtqDmY/byuBkeV
         5jmW6VR1LsiyN82TEproMlzIi10hrhnUDPNe2CVje7UfGZKXsEnb/MmsnqashwyvXWAy
         hmAVBVTQEJM0S71vrcKGe407ICPW0IYvVVGL4S9eJ9FwPMjTyCpaofbwWciL/He38TJ3
         2W65jkPe4GKj/4iBdpzvddY0oP+bm2wc+1boh3NmitK9o179UMFyYBdkXNqvVR1dJbYV
         ULVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763680521; x=1764285321;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anDCDfLB7KrkCqizhv6y9TBanhp1R+JWCM6vVAr0bX4=;
        b=oFC0OTaOg17I6FqNKgfpEEtCCbr/k8lTBDrIhGMlDtTL9FgmWE113WHhP9ea0/iWbg
         nN6Fk6uk6hrbjlmBm+4f3+oUqq46LPtEYaojSIrUCvtYuBdPiqClGZ9R74Zd3czNbObC
         uaUmPOi8DDHci/EOI0RVss19Tbi5wU6VxqSruWcGCkAesSrlH3QEUNxatBTTkMpvLD3D
         zBwNATT8/LysY/Ysqp+yS18+eFx58/QuDay/jG2nWaadtgNXqRsnWFDjirzwWZ2wmubI
         NuVzfhzQKv5LH6HUpwOaEGNj1w5zhBxEvBtT9MI9q1N1W1HZlH7jVaxH/+ab5HF5s6mz
         1ddg==
X-Gm-Message-State: AOJu0YychJbhHQEaifg4G1sITaSPGRGUGie5eoafN0g64UlKGh5Z7JRR
	7vrsRUQXfyUYI+zDKQpyIwym2MkBqCAqW9JhQmawSSEeqJif+PasRMmPCieL
X-Gm-Gg: ASbGncvuFdKgkfPdEXvdTRb4X1p5umkgX0ndIKJSGjM+8tOiLWJ5JMdA4tTCptwmwPe
	oTT6CUsGEItpjZRmtz2Z7fBQl8xyDB4ZUY2+7vtP+dq7rPWucZPZh/wFN4RexfyEXdc8eTvQyJC
	sk2rx3Y0n6BeQsKhXP9H6r/gQH7aONNDT7kKH9XGfN0pV7EPHVa/kWCu3N10p7yWPkXPc0iw7Un
	Qg7WruT7MczPtBmTDTdNsJJcMTutdfDRVHQOVs3czgPLexfDctU8OD6EsRGXh3zr/1MTIm75KHM
	pkcTDgKf3NBARIZWKUEf+m1Tn68LurB3TUqqqznN4qfkQKyw1G3DP10oQBOFEmd5uRwOJbuC+2x
	7qiLtkKqEgVNDa+k+ZBEtAPnmgK8yYMmypH78r0J0w9i/1Kc+MVVJEudkbs7jp1nAaT0YIANZg+
	y3F4ZnDF+u+LpIdroaFDnmmgw=
X-Google-Smtp-Source: AGHT+IHZGc+E+rr6NfQgJ6dWl8N+Piz3fXNAnQ4bXxTAeNTePc2nY6YpbeUvovyI0kUi1lJbEQ3YBg==
X-Received: by 2002:a05:6a00:3e08:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7c53013861cmr1210719b3a.7.1763680520774;
        Thu, 20 Nov 2025 15:15:20 -0800 (PST)
Received: from [127.0.0.1] ([52.159.243.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f1262364sm3869383b3a.58.2025.11.20.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:15:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
References:
 <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: clear scheduled subflows on
 retransmit
Message-ID: <41e8a753-6f87-b67c-298f-bf0e5579fde8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Nov 2025 23:15:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/195533=
52689

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/79d3d1a2339d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1026047


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
