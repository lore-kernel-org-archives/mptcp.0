Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB82A1BF
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305881; cv=none; b=rKn1o6Wc2Ywv6mOolEX7eGVd4sBNP/ZmMlhudvXW1a4vxe0gZP2+gWxcLAjIOtwIsxqO1ps5iqF6nNVON3cvd/aeI38g8rRYr16MEReCnEbFjVlljrKok7D6nFljPTtIFmRpnbjNs/iyHAzwuIHFxJX+7Bw/0b5s+4PQTQkcEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305881; c=relaxed/simple;
	bh=UfrJrWSP0BW/ZXQnb07LhpcYRDSi5i3wVx2pzRL3ipc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jVmX4cRCS5AbvuQIEK3dyDpNmF7XCEbtkluc3nrGVNIjMO68aPJsbBAP5voAwvlVydYLNq7bx+INCVk4yCVtAmMP3Fb/UHJAbCBQ5XdT4EfJSocqYNTo4JMNA1tCaWSsdeOiw82J/4BKm9DGHsoyPqhg59fpcy6g0sXAV6GOLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYTtWHP4; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYTtWHP4"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso18124835ab.2
        for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761305878; x=1761910678; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aIvV205drsDt6CvKFbl/mv6KXLhUlWBHYzWojwfy7I=;
        b=EYTtWHP414tnATNiN3WJaO9L1V4XFKWJ3NEKLMsBE0NQsMaK225yCGBJmJTnyc67Pk
         3/OCtWfNyGZlSPbt/j5toyGxP/ZSVqv0V9fSG107IJ+3Svj2GPtG84ijE3lb1gqN3WvX
         5lVKaihLWVNCJwnUgAPD7h+n7kPukiOIvNpcguE5MJKUSBUO1fbdb7953BXhZKnis8Sn
         MHK+eAKNqGYtZoxNdqIN8ALyx229vYZHQ+jSvu5gXWuOKA+HvumJstPLyZxexL1ekQIT
         8EDs+rRuyXuWxJTK5GeVLi5r0DqxmEPlXBisbTQrJDDn6gor4Vaa7tprRzIsIRctix63
         Kszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305878; x=1761910678;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5aIvV205drsDt6CvKFbl/mv6KXLhUlWBHYzWojwfy7I=;
        b=Ot3Q2t1E7NCNIeBnfTaSMGJB14uAw+2+TaPx1H9w65SbefLltp5MqROmBEPCBeQBU3
         f8VbqyN8N0I1QikS/VigsBBYFtfG6k+VXMjgC8k9omnWis70c/V6R6y1IxMiycwxLnax
         NM7PjU7Np6anZuNzk2+HsZgzLSVAYBH2u3YA6QEX+c0E3XP9vrKGoE8QtqJDjXRT6Wts
         JW3cuaZGGNj3HRWBu1qmqqxxk6JmmfIHZUogYfvmLlfz4eZePsb4GhD2XMyG6MA1G5wm
         saQag/eo51YCncrYr+dsYTpBIBPnxEdyQCzOyi6tQAMlggKn8rU1Z8Nw4GX9vzUszxkx
         3vAw==
X-Gm-Message-State: AOJu0YywnYqT2rGXOXlkf0cI0/8hfkb+Lzpe/OnxZD3foIt5hd4VI1em
	dN7RpCAa6O9LnSal2WZrCGwGYkjIfNr2+0u39Y3ZpqxnJK4p76RuLleC41r1EQk=
X-Gm-Gg: ASbGncvKWtDsXPeuML/iZn1IXv7BcGD/AOAr8C8Dtgz2mz1+f9zN4hTzMl6EVs+nMXF
	RWtRXcLsGBhp7sUasye4auuhLQ0h/X8BeOtuP6KrSLHMg9N96Qe6KuMA8wxgxkhJ4OVO38ZQQ7M
	SORNs6YBfxJji7AwHO+JteCvEVf+TPFKmSiPwLYxJZ5EBgSGmATBHAAkq5T3z+oTutJvpih2giH
	Inr7nCAeY2yOt7ShBfSZFUewsvPPky0pFjfVyCEQxDm/JmbAnAONQc9ViT+IBrkvMgz8UdDTKS3
	Ff7XTdGMNgU73kfzoWdgfVFbdUCC8zFxHuSjNMKWxOOeuWLUcySHHe9ZjsXBpEjwsgu8rS86pOa
	aj3HIw4V0R9xbkGANiw7aygWSTyjNQUSZC/EOrYZ5rueG90WF/k7LbnSW6RPtQdbfDGkDIIbzzb
	7NuqEut3o6BDZsiypNpmggDkFo
X-Google-Smtp-Source: AGHT+IGda2HRIGvLRiuhDFOy8S6K031o58xrRNlVgNq4fCyC8JNdd+aHCvt83/LP0s3fky66kBO/7Q==
X-Received: by 2002:a05:6e02:2382:b0:430:ca90:d0b with SMTP id e9e14a558f8ab-431ebf6c927mr21987775ab.26.1761305878024;
        Fri, 24 Oct 2025 04:37:58 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.181])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb85c4133sm2039913173.48.2025.10.24.04.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:37:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
References: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_join=3A_validat?=
 =?UTF-8?Q?e_extra_bind_cases=22?=
Message-ID: <33da839b-01c9-4bee-548f-e8680b498bb4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Oct 2025 11:37:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/18777184422

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0db3101c3b80
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1015428


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
