Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604833939A
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355950; cv=none; b=RtZfTMqHCknhF0cZHL/QLRjsH05KigYHcyl5/cTZ0EiS9OOi9E9iII21lpt5TBxc0H+l0VGiUTY6wy1GX2d3Xwl48nD/bc95Hn/YVf6miCC4LxAz2ouckKSAPRDJpUij0e4VIVgM4Vj/sQOD+VPKJXydIUZsLT/qIp9vO4QZvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355950; c=relaxed/simple;
	bh=HlD4pNTyCwyd61dQUAJFtNa68NIaoktpx/FMXqjRydk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XbAH7JmFndCVKvNYsTigpUlrmv9B23G2gTl1YEH48YjEnyULxeqwIG3SfDL7OgB7GccJAp9ZsJzVUSAsEMJrg/8IMsyZUlhNINDxD0I2cX6mzztohQqyVh8Z03/K/R9dTSm3NoZAgwd3YCkro02EEOscaoa6iyP3XpcyuBxfrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h844dXxI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h844dXxI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9392aa26b25so118070585a.2
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788355948; x=1788960748; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mly5yMqjiFdr021pS3I+ZRHwWQZB8LxI8B8diqOv/pg=;
        b=h844dXxIz4czy6QIElibJcQWMClRGO+3PODjtsa0DMBvXLhKDCjbRiFGs0F5S7mxOl
         V/pbTAEOpFrV6UyXfuvY9vXWfPH+GzV6ufJ8nZW8O1W2xlU1q5y21SekHkDXXZK16GSO
         jzgtrbOLdUlRLq/LqpQ6zou5IHZmKh5kcOPtnc99fW5H6KG0GtxPUxxHe7p4VNEwRXzL
         /3u6o8MVwaq7HcloqoHlF6S62iJjubhQl60tJwVUqiGVUKvsSeeHHTFt2R3+90ueeg2f
         0/0de8enaU9yJZMoFFpAApcRSs3SepOjNXgpR5iFo+/alicYaTIpQ1N/fXyg518H0gbu
         H5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355948; x=1788960748;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mly5yMqjiFdr021pS3I+ZRHwWQZB8LxI8B8diqOv/pg=;
        b=rmV75tgYghCjVZPl5fKEtKKInjCok/8SaL+s+WbYuzD8o0tp2eoczlXcnm4heeIAb4
         42ttQQr/OvkSDBaKkFVZd2xHRg9kH4ajuF8m37qprvRx7URaua54JqFZ+OnbySb+1cv7
         5t+ue3KcXsPp5GJOKt62al2U3ov8l9GyFjZfMwkleNjxZmrZLcPd9RV8n4Ruu9tby8+P
         /6nw8KFm7zVhZ2sHP9mj7mcVvlcOH5TlKVoUx7KKMIs/P9+Wrd0SCDzunK1MzDuPxHt8
         n5QuK2+xpRhAs4kdlJp86MldOOHKt+ImwZpoyrDT0ay/sSJFabuhauluTJemCNPFrKia
         UrxA==
X-Gm-Message-State: AFuF++kb1kAmaYe1xC7SD2VnQT23YJb84baH77pvcNN54OPa3JWxvRyB
	Hrl2+iwRdirWyY774Iq6mcGVZBmq+t9WKc1uKWTdvjFML2G4x9R0tmPctpEb
X-Gm-Gg: AR+sD11/fs54MIsqy8sxkqUFg9qKxVycER8l94MT/dMLgxKvdY3p4MtuVhVRJyX6N37
	V1nXOavVCIOtlD/bXlJA3soiThcZsBBx6x4izJYMJpHRYCaBeJ+eIyN/AoVdfxkvr1KvCK3f1eU
	02oSV5lJORKBP/mxx2Ut96NMleZ8XNfvUtQCqIfvtPsU5vv3JuT0C6TWbsB0qHTF4FPfjiJGdoD
	ccTHZdB6bHig5rb1d/8FUpisCo0EqyoVSxFcWaPTnixcg9faK9Ixh6Lx3xgx5nDAyxX5gxrXoUx
	tq0/QozERTuY/yNrl2g6ra2YFX8dbUTDoBTMKHHziIUhA+ywcbSOP5cOgUPvaqZSPp+BywxQHPc
	yzWgvBm5/vnstwbTg4Eg0rGjn1ZCtcDZJOrjeoxpWidfj2mDR/YHMAgJdvCeObAcbDZWSegUB0G
	Z+tw/JjjY1kfwP4Ajv3Tn1SqBU7Yu6u4hz8A3ZsD6fYxarK1xdJmkpzJbmHvL9lD2tHi1MeuCpK
	X37CILdGFk=
X-Received: by 2002:a05:620a:27c1:b0:939:2bbb:b266 with SMTP id af79cd13be357-93960ccd7b1mr585588885a.8.1788355947873;
        Wed, 02 Sep 2026 06:32:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f359ffbsm203837485a.28.2026.09.02.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:32:26 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
References: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
Subject: Re: [PATCH] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
Message-ID: <6a7d5068-d560-95fd-2fd5-38ab9f2d3a3d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:32:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yilin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33631744638

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f9058346dca3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1156129


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
