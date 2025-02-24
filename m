Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA852F3B
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372469; cv=none; b=C6EN1b7HZhOfUVDs+jLz0Cy22YcEe4CBeFKIY4TCYcRuElXlZp1HJbOXj/U5JTF83JAegfUGwA4d82aKRGeWwOB0+MyNBSuRYTnXMLoCy5ceP4wq2Up6xqdggyWPFk3za1a6O7k2S1peYC5RcbZEz2i2PGozGI9zHRi32JzDpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372469; c=relaxed/simple;
	bh=XLAXJpQm4E9mdSPrmxQyGM1Z8KF9ZfFgfrgAkiqxXhg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SM504t8XvMPfRJigQJmybSgqrMxNKdw0Ddp8aUQcT7TTphG7wGyK5i+M6n3fe8KYtIsfmheis+3SLWV25ooIoj0jBF/e0qJKglwM6EXoX2q5fITfdh5VgQY8qdErOfZPEUwi1zvlqc5H6OKVUn4k2d3g7HIEecJ1e4P+haZ4jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWkJs1Ty; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWkJs1Ty"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e67fad4671so35872546d6.1
        for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 20:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740372466; x=1740977266; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ZxLsNO9C+ipZStm3UnBuhmGpMNq1P7dHynvg3QYag=;
        b=nWkJs1TyLugr3QPdjd98U5vZOm/NYvM2uFqf/REXJ8HLJG6JYHMLPA+8ns3mRj3c7U
         +DHitXWKIiL1uV7TMG2sQKC4kS3NSXqi6xPlCcNtJOLRgXkub3STvS+5WsUwu4H72VSC
         agky7paT2iWyG5bP1sRvDynFHvgonWNaw8Ff+BQHcoNtgOfHEZshjfK5uctjcJ6SZM0k
         nv2fVXZfeYRmLJ0RzD4WkRTWUucOXSMnOomc5VoThNYpGsjpF/Wh3+7v7t9CoLBiu0g2
         ZW3XF9KCz1G16E9sKfyG3W3YlIi4NGdYtLIT6mJlVI/s+yjuLcs3tsbmDD+hgWFnPxzC
         k91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372466; x=1740977266;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4ZxLsNO9C+ipZStm3UnBuhmGpMNq1P7dHynvg3QYag=;
        b=w9BZ8hLEgTxaLlAtv2yBcUtDhKSM90tAq3+/vx+BWDBfgfjrEC3zwGcmQHFcU7ouo4
         9aii1C27LIh9/BXhb7nezUtcQP6wGD6rOX1r9XLQwJufRGyKiw6rBNY5j5D0S5eEJpTi
         Hs75CgUonOChdeqYeuVLzjXGY7koqfqmimLWIHjJhyldkjHbSTncmFecM0MlU5L4TRUq
         f9C5SgLDYLkFhUjmFuS5qL+neqbVnXTA3oTUhdYHTJX5hDY6UR75GSc0lurcMPgEkbVG
         JWpF7ysG9D+1Z9t52BN0vroaIk2sfbZ5zRRCtjjW/IbHEPFXRtIs8H+fdtD/zRWhGqiG
         D3FA==
X-Gm-Message-State: AOJu0YzVLBckn+JZQ7c0LAPX2sc3ulYNrA0r1W8XmH3EJt+H3pctyads
	FCyUST/WlwMwOXD7vYrmCXz1GamWVTbrYFZ4vThFXF6LGIaqoiqSJg3B
X-Gm-Gg: ASbGnctfblV7oXuQlgPp/44NyExurtX79zEXzkXUIYULhE874kY3lQsCcZotyq8/SP+
	W7c+uZgZlfL+F2WL3U6jD1MNkKRmtHy1dcpPqSt4PMlqRqEeHvbR5S3t0N7eKToID2pDOVXz+wz
	98RwldS+9MNIKEu1/EnUL1G6HVAUPrivkbTiwXOLtsJ7eQIaGxhgLQPnkj95vtG3AC68bFTOWrC
	Ov7kP+cjFdHo9Ia+o9iXy5dbnsHjLvBi+0HXHB+8G4gxwBD+lQuDQ2wzIwQM2v1Vs6n9M1edJkP
	4fe8tzl6eIKyNykUJ0SM2PC0s2wLTGQonJc0
X-Google-Smtp-Source: AGHT+IGnzh57WLA3coB9I7mnS4LFSUnbfajNn3fJDwO9sSshxjbmA75Q423ol7midrYE8LrZqIvNgw==
X-Received: by 2002:a05:6214:daa:b0:6e6:5cad:5ce6 with SMTP id 6a1803df08f44-6e6ae7c9f82mr164013896d6.9.1740372466609;
        Sun, 23 Feb 2025 20:47:46 -0800 (PST)
Received: from [127.0.0.1] ([20.57.79.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720e09da35sm59470221cf.59.2025.02.23.20.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 20:47:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v4_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <46bfc776-2ba1-bb59-8c44-a8cfaac8f6d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Feb 2025 04:47:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13490473539

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9fc290ccc06f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936873


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
