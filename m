Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD013C5826
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916713; cv=none; b=p9mSRuJjEcl087IMnUeqV5suM03ShU4mQ5krs4fNl0mUOHW2Zny4prcBFC9Fwx9xc2Mz/fUEXSfiU8tOm4f/y6o0tseBF0Lgb1cKXiEDFPMNz0zseyksVoKimrIuR77KgHO8gfV0QuwcnJW8KTG0DyrFkmDiFUiMnoh8BPe80Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916713; c=relaxed/simple;
	bh=wij+uC5f1va6zsWSXwnTBRDEkcYdII1lbvuu/2OywLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=TfPuOwWdS+/ulZT/dv5RlUkevaopNwZ+19h/w/202bN6iqrkjOwJ+JEryozhGR28L/YxxkTcLYxrIZEjGMA//iFuhhS0vk5PsukfjVQIhhnb/+3e+0E12yO2VDTUTyRomQnojEw+I87gVUdNZpzHvpFekdxFrEuAmdOwnOWwi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhUOE3D+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhUOE3D+"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c8e2e39easo6805381cf.0
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785916711; x=1786521511; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kvOKP3MkU3NfA52ibF5wmvP0+amwaFBSE2V1OysupNI=;
        b=KhUOE3D+Uhz+1sn6npyzxLQj2gN3vKrCFGRoGcDUahscEeKHJApqojF3yecLYD4zw9
         rRUobUdg7Gm2myYsRDwq2W5z2uhoJWk7vNLlyczEaCP8PO6DhETUwf1lBtZMZ/18ndRZ
         aH5oCACLP15W7K1ldkF01mAqznfd4pqPgobIVhU6SIwlYxKmjg8NvI458AkdTz4eUpeF
         2Rdp8NeuDQsFKB7NuuCnz30pAopcyW3zarN2+6hpAvgcCZPUv4RbGHiHaQiaAyKCLRnR
         DhzaG+RBN7ewAy+w2R+GdT7gyansyvD3pV108dWiTzsZrLhUG7FMvPy6SMxkegmHse8A
         Yg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916711; x=1786521511;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvOKP3MkU3NfA52ibF5wmvP0+amwaFBSE2V1OysupNI=;
        b=XlIt7ViQ9opSm6O5GQoTW4B4hv+zB9t9um5aqzPvHt0Zo1hJ4dWptyMp+kPZlO68O/
         OHOwKvONibRNsg+DNTsGg0mu9zsli5Sw7xw6nwpA5WTEiRSzELFKbq6LBdFrFOnuQYsQ
         qdYhZLPAKRWQ9+9NYzpHlT5Dr22EMr09ZQpPxtxJuSO4A8VCZBa2KyqmUBAvt2Fx1Meh
         SDLQMVn2miricLhmc1AeugHxR69yJUZNhwsMoS0x8LeaB0h84d5nYEyM0W45iN3K560j
         AdJnz9SOFqzcn1Km0lmPttJsp0b0wRt4R51M1nF8/osQSZ1NiUNwvjw+3qOKZHizy5n4
         EUAA==
X-Gm-Message-State: AOJu0YwG4/5cAj+GTpIiO7H9kYpQdanepTn0a1Kd4jclnpFMFLSiyYon
	qXjdtrGamH5m76cSHIdaq85iJONBtSnaMMMkg+4Y3V9P1s4aSZCwVnA=
X-Gm-Gg: AR+sD10C0kSNepzOdswB3xGCTz6D41hpESueqgJU36eGLf7DzgF0riSqboH13kpRGJT
	o/mxBSTYuRcyYVIi/oSx03rZK65bIr6QDNynvZ1y56BzmWxDkUZ0s0TV8hhI/IsFSQCJ5Et17S+
	cqfy0BXbz6XZOcw7NeFeXByhAi5F/Gzr52YAs3jh6mEt9HXcvYW9Mf3brksfyDgOijhRRIrcqbZ
	p+DpztmIdEknbtqM6D1ZAdM65zGJ+VqRb626Po+HGJmv5UByIMK30ig9IP+ILtfnc93GJsDYPLY
	0BN8I7Wc6EeXqeaJMvCy9Z8H5LHRRmRYNtVcd3AYYgUeqWgtI9PdrppHE9hxp2CGC7KunUjQ1am
	odv5VY6RE2cSGQuQZJH8vSW6hy93WvNYW/e1jlZe3I6pLOclD2lXfsPcoQY9EFR3Immv0L0kP32
	5K9AaFjI4FWbYZv8rcrJYopmY6zP2/Ic0V8xAfD9XYjymf7MfO7giPInOmKsmBVn0htN2sZ1W13
	AzamTFzvE7oYQ==
X-Received: by 2002:a05:6214:5084:b0:8f1:7a7:b869 with SMTP id 6a1803df08f44-90881396a88mr52277916d6.31.1785916710599;
        Wed, 05 Aug 2026 00:58:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.224.247.165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffb8f76sm22290856d6.11.2026.08.05.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:58:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
References: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v4] mptcp: honour configured min/max RTO in
 retransmit paths
Message-ID: <707c7e55-80dd-5b62-3f6d-0f9480ceee62@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:58:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/309834=
30746

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f8bc9a73a07f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1140556


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
