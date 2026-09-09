Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441253A88D
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951803; cv=none; b=trWHRTdSmO1VQQ2zugw21c0TM5Y49H60vrufvTKHnbNoNQ/6PR8eDZR7fY/+G3zqv4o9vI2Djc5xcmkftTpXf+7+5KgfgUeumxBPPsKT9ss+weI82volCM+8di0db8uQ7lgP/TVPkUOCqfkv0OvmxeU3tgmXRRWVcA2eYm9iVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951803; c=relaxed/simple;
	bh=V+1X5lgNwEVPvyU6XfxYvMyq7EEUSYamxLOhheqMH7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=S44PtmFn7HkYhNX4NOWbVc+tK+BxYPR/N76tf1elWp7GYYLPH1QBSzhsyIIiM2O6HMoJb2FaY+9ksSx3ACuLf0fy0NJbr69HHzKDKJqqM/NKRayA6EmQq8paku5KHLfQwMXeBUSaUDetftHo3GXkZJ4Fx4kvSFkTauhLbUdACOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmyA/ary; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmyA/ary"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0c89e34so32743a34.1
        for <mptcp@lists.linux.dev>; Wed, 09 Sep 2026 04:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788951789; x=1789556589; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aID4J+tpgckdRPYmrrsCuy3XF+DzMssw4GeLYerJeBw=;
        b=QmyA/aryhW2tWaAF1YGhDY15cXQwIGjuKyYEUUPtOTrmlQy6KLf9RdjjYKjwQHaTES
         O+cOGLOLpYrH5HCDCAoD3mpYwg17YKRbMthmSA1W5PpTt7IJS02SLCGMmdOG2IFPmHzp
         vSOqKk4mYytCUEHd8kZRW1ZqJNQwc9WRgctcYSmP0X+MsXk2xVYESxWtUMJWGgJYOOnj
         WruzSBw1lkSpBzB9L34MvMimGuP7hODiseExxxoi/m5/Qp5oZHd4hplABd99rrNiTZp3
         WvTBgNRjp9GD14zCNmvJP8uCOTHzhj4IKB1YXc2xmiRDGZCdGuLPb9ytVEMylpI0AAKj
         zpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951789; x=1789556589;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aID4J+tpgckdRPYmrrsCuy3XF+DzMssw4GeLYerJeBw=;
        b=FxfKm/JfkmdyIDdpa3g4bBK9SZawIUexFDcZKmzjrwdJzKBbL1S/y3Uuo/TT1zcp+m
         na55tOf3R7mC2jOXtHADfaDMCML22Kuh/KhJuSvcPs3nkuhnlCvBLGNRUgAVF0ezXWKn
         rdfh4RcReQIUy0pzXQUtB7wWW1Ty0uMlxD/dzSklt3jlf6ochNk4SvwrxqcPzcUJHu5W
         PE8uquUp2niCTQhXkqQrRoA8FlWGnJBF0IKkRV7HRbGypA4U1bnKYz4ZvixHNuG6LHzL
         Wuxehv5Vzo1Ej/Mb4iJXjIRHEIrmcYK0IPVFEcNHXSnF0LaGJZMKm9CoJjCLlriuB0TY
         vAUA==
X-Gm-Message-State: AFuF++nF59czCil8yQjRjDfkvd2qp0bBCzxqXuz+BncxWhcxWv3224Ct
	8SVnqh2TjUWIomtN9e/UFmTVzcn3ZxGn4jaFfC+jzggo7+bEyuzo64REX4Mh
X-Gm-Gg: AYBFou3qzb4KszqrQVdsM0YdcFUXe2PQ2xUiBVLkpjldnmXqOsQl0B7OgtUDCvUr4CP
	I44RqZCoDplwVHOreD3oZj+EfM9H/puURh4wlENrdSIq5s8ym39daM5b8Gha1TQhJDHitKpbKld
	hhycUXB39wduZU/4kk2fc3U14aJke2ZiqE3vZPihxC0m8Sqm3r5GPEuTKYIOa0BbyOllBkcTq+F
	1m1lkcO5kKac7A0xrg8YOl6ApcjagGhePAWYZT7g3MtNwZitKn7PRKzihuQj5e+tJLeCYSNMXhk
	eWtlEBXqRVIy4b0l+1Y3LiYgibf/aAAMfj9jJ9o5TyfFriycLswelbWgB3cbd11FkxDeUoLK0Ew
	1IhbgTMf6M33fG9O+2p9XeJblKUPo9zahwzSVTOQ2BouULKyQAVaw9vIh7su5Gboss7LnhJdVEf
	7ZKexDcXJREXb8SHu2Dx9XN1mQG4SSR42EDVQCEhMu7K1+Xtyn9FF95bodAbfVSD4dDGRIxRmLO
	SfxhTyi7m5kpdQ=
X-Received: by 2002:a05:6830:922:b0:7e6:ef1d:4aeb with SMTP id 46e09a7af769-8020fc8ccc8mr334033a34.15.1788951788267;
        Wed, 09 Sep 2026 04:03:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.136.247])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm17521324a34.13.2026.09.09.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:03:06 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260909094800.766170-1-kalpan.jani@mpiricsoftware.com>
References: <20260909094800.766170-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v6] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <6d25a138-29c4-62ee-d2fa-79cb0328f626@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:03:05 +0000
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34338526910

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/09de406972=
ff
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1161206


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
