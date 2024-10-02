Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3E1D0DC3
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885731; cv=none; b=e/WP8fbf9kDzMxnxwG4btajmoO/0iVa7vhZ+tIzZWdpw5wz7EWLq32IZg5PcQvktvI51ViK2EbOpMOVpovFzVHdEv2WOdj1+BHzoiAQDkVfNRYiQHOqWXnXPgDvh+XKuZbgqglGDyn9/YKCM1gXgmdbypDOOmAZ0roez5iPsjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885731; c=relaxed/simple;
	bh=RmwfWyc/sLwav+mFdN/oMUeYV7qC3hchci/3CpDWRh4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=afzO1h4gvaax5FHLijdtEJZMW9QOqFF+fUllX8w0XBKfWQmiE0UFB+amHEhHtS+Cm/4cXZQEL2x7rgnnrKorQCml50Q1NsiQTKT40hSyrfpBKvHyF5gCc1HAk/aJr88y6fTfbT3S1Ban0CyAW4neIcy0PwG2uKE3+M0Fw+ikgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Ks4xRJ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Ks4xRJ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-710e14e2134so3809669a34.0
        for <mptcp@lists.linux.dev>; Wed, 02 Oct 2024 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727885728; x=1728490528; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHFDjq3AabijXDbsHgCTme9379Cs3RVEuZMPHV9UGpo=;
        b=T2Ks4xRJrkdGTGVST8G4ZR13gel+4m3uKTOuCwBHnGbvWI4DJZb1HyB1gpnVIbYHzr
         5lODaH57zHQvETj0DHyVTBBRYKEVOe/ho2zS9HbdRmJAnc7Ptb4GRPZyJPNe5JgjBuVa
         etLFc2SUJ1ronr//BBkQFlgqFleM0pVgkgXduzo8TPj7gCTCwO+leCKIVCIYzgNC1C0g
         yy/5WoLO6cyUk1+Z6wgIvxAZ8Cey5nOEMj7I6nrwYrjwZ+o34ddkWSCOzZqTMt4VQZ+x
         Mj0YeqLiUzh8K9GuD+4rz7B6INZwQSEvezdv2epfv9nh81DIqt8oYBNAT12y5qnDaoKz
         aBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727885728; x=1728490528;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHFDjq3AabijXDbsHgCTme9379Cs3RVEuZMPHV9UGpo=;
        b=gNOBleMmxcFJGwVSAP2P+Hr97US6qHsnVH1G9bHtUjl2Q0zl7Wmbf0KTNHjdsx7Xhc
         D1RFugXKgxnqe6+cWvN7r0ZFCz24mOfkFQm6WOLwg4t0goaLyzpKSSuS1uaK75EPxITV
         Db92je6MNKLdJVvtDpz7W9R1IWyVjBylQHb+FIm5IcAB6eZQjwrCt+n1u239HU1MIMtY
         TMzYAZRq6LiOpVuoL7rVTTgmxzutKXkbfsGjutoBB/XqhdutyU6wlFAJxwAcTJzOUOmf
         xPm4l542FB7Di4NxEOAEQ44JCDgzX5uCVa+WUunFY1GKWthM5jcDScwRkEkARM+IAH7K
         bL7Q==
X-Gm-Message-State: AOJu0YxW++5GhpWp5dWqwXNZ2baQ4CUuqET5isBvSWysNgY9XUXatKQ1
	ooKOLiubOYboPbzCuELu0ymRwu9VQS4qobSv7NLTtnGSkbDS0MW3gRKN
X-Google-Smtp-Source: AGHT+IHEiVhoO9dkkSNZZzrjYrviClXtsEXk+NSvdUO11S1pdYp4DfHlhseG2wxKHvgFI1s9qRDFAQ==
X-Received: by 2002:a05:6359:45a8:b0:1b5:a139:4d92 with SMTP id e5c5f4694b2df-1c0cecbe65bmr285472255d.3.1727885728283;
        Wed, 02 Oct 2024 09:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6802fcsm62313876d6.117.2024.10.02.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:15:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/9] cleanups for PM interfaces
Message-ID: <9b7a3ac1-af7d-2cce-1d24-9be4fbf6ad6d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Oct 2024 16:15:26 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11146665787

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/34ea1a439a3f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D894874


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
