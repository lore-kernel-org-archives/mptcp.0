Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595211A7264
	for <mptcp@lists.linux.dev>; Sat, 20 Jun 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948274; cv=none; b=p2iPWC6VoDdq0Y1VB6ACFQerxaf7EXsYb2n/KWS9cGchpRDvU8IopD9GSKGq4kzOcXRZuMyi0yq45W/Bzy/c8K7azbOUrLDHDYJvUYeFmdOoR0TG6VB26NFEwlvkPEClquKBgW0YmMdI9Svhr8kcu+yd6amZ4r/doq6BuKJBGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948274; c=relaxed/simple;
	bh=4XXLDX+OrAssT8qJqfb/8QY7yav/QGIf1dqNtuTWud8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GbWXGXGQukm3G/lf+v6TOm9EeTZN15f8ftDtTadXWezFIQqR3+Ym2nOG1k1OSqHY+HMLJlLM37CeF1qZaSqw1+meJ8MOMlLGHhhp4QU12VjpasMv0Sa9Oz89NWNE/9oSOsLIATVtn7BCBCegNVG4pTf5lLahUJQarmyBDS/lasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Te3r6K; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Te3r6K"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b9e755555so6214414eec.1
        for <mptcp@lists.linux.dev>; Sat, 20 Jun 2026 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948272; x=1782553072; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/35qdNWPVkiys9+VCWt5tXIKK5udTxhWkIqW7ddK0=;
        b=b3Te3r6K2IcqXh+IJPN5AuIcdAU3xSLGJbAzxrY+bP2RkhYj7WJHf55CCXJhqk5Xsy
         uny0PohnXfX9pgsgQ6KF2Tg8/+z6uCNwDgR6AY4a2nMbBtfFGbVqB7ZkkadoToOF6rSj
         OQ9zwFiWgNGoKfbmxBFvImZmgUanGlse/76vhqMAnVclurGnO4vXrT7NuLudeQGbCwOl
         J0OWFTTPzYe6LkDiK1D9O34LpfDFIsxyBXOUj7bpQLIKr5Bd1uwrIxLMMGt0S8MAFleJ
         0735+tXkFO33LRrzL/3wBShW277DVCVJuQr4gNh0iDUxpxMEkaXDlf65RfG1gFvtQ6Jw
         hQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948272; x=1782553072;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aB/35qdNWPVkiys9+VCWt5tXIKK5udTxhWkIqW7ddK0=;
        b=XyCEwDKs0YXHHVmRIFfRx9t3jUqSHTnHa9wwCcJ3tGz53WkNXBR4/5WsVBGJhwpKPw
         mWOjNy/GNO/Wjtu22/zrEYBrayGyuxDQ5JflM8msEmIaslHIx1rovNv/A0QfoIQAsrnn
         d6MPvELCzys6CpjgxfkSP/NgAHzkUEt6wWFxltJSxAaLdYGPEQfO0/YaB9VmYGHZ2Zdo
         OGJSgJEcghyoPBykCZDHXaAXhxQmBKwVAVoK18xk98Rzw7jm8WvbB/8gqwwAO/hGrqAo
         tvd7cyDHUNLKQd0N8Gj/Q/nycVzueOIrtwRKF4lrU4k9WyYHScc/0CD3u/ncgfcAB/gs
         GhMA==
X-Gm-Message-State: AOJu0YzGHv+Mk7qJVvoM9677dnrYqhNkMQwDYoLHF+216wlurjJcZlnd
	3bULtkYpHjBySRpURlPFpkdJeVMVlOKEP6ybyq6WJ0hxMfoHQLFtE36zILfi
X-Gm-Gg: AfdE7ckj3/9+Hs4Kt7zznNd2uxeGRXPOIvD5VeVfCveppm2NO/XRWwGdSWWNqh3BrbL
	4kUb4kNic1YgbtUqKF/YFX0aBjMCp1oLgBfRZirOZTENsDoCYpt9wde3jJ96xY28r02kZHZgcRy
	JI+20TJusjGdUP8//gGJSzkPJ10yFR0XuAJAc89w1J1FygyVHnwZdigQyXUejqLTI+SwPL1VuOP
	bcJnAJiFnVPMENR6LWXxm5ooChJi7qN0MbssPkWf7iJb22fsrFRiuL+3VehK+gH0VLOmZeQ0Z6u
	EFenwap5x49XgxbWiECaP/KWUdAoLMS6Q2PbQ+mXnc2tCPy254CIlexV+Fkp6l23z+AkU9pwgZo
	g9ET6xue6plKqaZ/k6p4KsocebUyaH7914zXoNlzgGV7La4T29ELsY19sb8UQgfvnKBYH5CvEso
	pqT0ZXVnvkw/VjYWDdB9GJPG+t
X-Received: by 2002:a05:7300:c89:b0:304:e58b:cccb with SMTP id 5a478bee46e88-30c06fea688mr3816624eec.2.1781948272203;
        Sat, 20 Jun 2026 02:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d779sm3071228eec.17.2026.06.20.02.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 02:37:51 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
References: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: pm: net-next port of the
 alloc-during-teardown leak fix
Message-ID: <ae921201-96c0-fac4-77cc-c693923d12cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 09:37:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/278664=
29471

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/971d1ed29b64
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114146


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
