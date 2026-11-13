Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570225;
	b=wRqbcKJzSpOY6MscNf8GP4PkY34lkxVkfewaFsK9/2o0LNPmDXlLR0wAFo6XARSU30Eu
	 xqiI815dYHbZ4rouuu6WfR6ixMDYoUDIeFHeXwPRyzNoDBq3oSZmT7ACRJkI9kBNvqhnH
	 m1NzgvE+gdnZrrgJd/oXhFJTeMqsDwLlXPZTCW5M4dToAgGXT2JZeQzH/OemWYepIXLMx
	 0Gfu4I3yuT2ngoy2sTXdwVzAOqT7D5PJwfEJfZup/NO/paj+pPVfCy2EYuucrgT0oPg/I
	 4i/QpGJqEg2TO1jS4RdFgUmwJYqnYg2e4W/wE3fxur23aapVCIGzxbzZ8iDDNHqlsZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=qMrtvgztiYOEhCmvDJdAQ7aE7UZxh5b2s3/khhmNNO0=;
	b=tDSjtMY/P/8fjZOgQTU+sB+OFHkO0pRj5BV/IOEQW4OfXA487t3hdY9NN7AXtV35YSvm
	 w96O6WoIRaRILUgvn8Y8A0vx00N12z77irlfLu0fJ5vtLL+gXkQobaScu8XP9mRISU1Ao
	 /AKikjmIZMhJqUFZOnoxMhUpV/ClLoODrsmjykeL3F7GYUJaFYGnJnA/CY9o91duM7lYG
	 pW35+hu9RfM5QNIyiihld7XWo8iX5XGs6aKLQkePC8yC3+Q2CPIMRKSboBSs8X8a4goXy
	 R97Q7FWFCWAzU/mkUJYgO91P2Z8ap5VGNod2YZqTRg5qACKp6NkSpPZu4mmmWSQRSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jyJYlPNq;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7A606A32E
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 11:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C7A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jyJYlPNq
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9eb579c0eso4623105ad.3
        for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794570224; x=1795175024; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qMrtvgztiYOEhCmvDJdAQ7aE7UZxh5b2s3/khhmNNO0=;
        b=jyJYlPNqYmm7P/Cgi8bK2Q2PU/E93NkW4S+F/WNfyE8Mt5IvzcNnolEa1Te9tKPb0q
         sQBAXzHAEluVSu6/IWrz/yJTbuGX7NbBeujWnDTWu/ZpmASBrKvWgQvgYX/V++3TxDfL
         tROqEPCDCOENjvMC8jDSQGRClCGU4YOOqY8uYAFCxyOfwyPF1Wr8LOVk6bakKjbQDjVN
         mMbTQUgGKhAJM7vS8vZN3tTOMUJ4vsBgNK6kwkcbfNzzx4a6iX8n1KY4yJCxivCO6XJU
         C94oWBW9Nbuy2B4ypKMrNT8jdb86mff8G1seCNLlaAVM0kQ7QvWofAowgRZ753+tN1YT
         pfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570224; x=1795175024;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMrtvgztiYOEhCmvDJdAQ7aE7UZxh5b2s3/khhmNNO0=;
        b=PVORNBMZUTZ37KB1/GxzgkPMQq09XtoJ6dCQkM/ATf8ASknr+P3MukFeUfEwOxmz3H
         xzd4vxT73KuMDzSG7UsxcmAHCxoaIiiNdMMuNI2iEyCWB98BgfsZYzlVDi+qwue06R+V
         uSUgWM7TBmO+zW7ZwhZWpDlQPAcx2yw0uSriK81UFV87UllnpJdABjaYv0wpNK0spQFx
         7s/tmsOuyesGNR817PindY4y92+inHv9dzKxtWB44IdZ/pmxLF36uXyX7dVp2NgrBdTY
         uMN6fAvQqOiMggJbaxwroVpMVak1SW4qCq6S4bAs0Dx95wbYEkVaP/vgYQNpHO+LhkFB
         DYAg==
X-Gm-Message-State: APuU4Z94LY3JK+8bKP/z/VyDgrRezekF/4TcekSdawc2sZiOHFpiCJGr
	kHVxS2U5h2jEf+v2068SmosCz8cvJGwiMyUofR/W8xos7rwbgywhS2cyRcSfrPA=
X-Gm-Gg: AYBFou3iFDw0mj/woGwA5KFrV4WH22d2uYu/7Gcp/6b+NDgHw63ZyYIgfC9lVPi/qkd
	tUt6fE04rVtxGEkB77SMWFpsAFB2htTsawdmYLGHNl2CT8c1v7HIkwjDQ/5Wqu3AGgxqttOHS2w
	RtnkAfeEKPZAU+pWoX9ceS2apOZks0x2RiFE//9A37Y7jH0GRIuhXhsEi2mpuxfkeRHwtzYrLg6
	VN6SS1FIaCkeV0aEaAXCDaBMZDFnCiTqfgNkUhUFBjrj3MCA0QWP3gm+OolVJ20klNxYLqxG2nv
	kWc12gTBoX2sGajb4F9tPmntUgb0zI5fNHlvVQ1myTg7FIyl1WCbVrW26WnzCsZSRRlKl/yc8nT
	yo4xv54cH/OaPwjsTvW3TNGqWDWWJ5FPIxU9pSxFA3TGWQeU8CtC19bP7VyfMGPLrlgstsbPsSY
	GpUrqnYo7zr3eOltv9bWxQZ++HVkKW75umAQ3rbn5b/r8V/dBWKpXqLOWrGbR/PafC+L1w6Cn7/
	knLUBmNd1dwSBiEERVzbsVooXkY60crrNqyODsDjDTwnDcU96N7NeVbGeOKcYRg7vAgMYayPqce
	Yt4OWC9SaJrO3zZzNTtjIUUpxYRow71pPPxa6RXlY45bBRgZ9oOCsrGoLX9k8Q9HU39xGE1YqIL
	1MjYuu3CDUAArlR/2Ew==
X-Received: by 2002:a17:902:e54f:b0:2e9:65c0:b5df with SMTP id d9443c01a7336-2ee0dc074fdmr21995695ad.47.1794570223928;
        Fri, 13 Nov 2026 03:43:43 -0800 (PST)
Received: from github.com (ec2-3-42-157-170.us-west-2.compute.amazonaws.com. [3.42.157.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c98dsm8879655ad.17.2026.11.13.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:43:43 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v26 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <37235f50-5e01-d298-d2a8-83dbd2126a1b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:43:42 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

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
et-next/actions/runs/43407382621

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a83eef20a1=
22
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1210354


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
