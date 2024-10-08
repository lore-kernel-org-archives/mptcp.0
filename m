Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADC1DFE11
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405917; cv=none; b=aE318twNdx/YTeOocoXzvl5tb1hbpXpYuI7C9CA2ekKP2bssy1L9fkM4wDaAkvmgsL3BSK78H06KMh0cEXcvsB4OY6CbHMwDj7y+GQOpQ0wlIpXLQ2fmuA53BN5Yg7vkvf8EAmm9h3xcQcke+yYqKgSh+WMhQ7fGRsU99c4j0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405917; c=relaxed/simple;
	bh=8Pi4b/Kowhmc02hpcn//4CvLV4GXtvPwETXS6HNRqnc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SJr7HMarN/62iONorzBctJK64r2Oja+jPFDiFyEShRFN8hqBVJ1AJ4NxJiKJRydvwT5vvOwHgBB0sxx0+BmwYJR8TaH2EY8nYVZeizP8uuwwUKweHHgqN+IiFX1WBUGB4nM9YbQjmxTuDqnLqGphVdUj9e0Vqyeb0NUJVZPyqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQs3TTno; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQs3TTno"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b58f2e1f4so39851145ad.2
        for <mptcp@lists.linux.dev>; Tue, 08 Oct 2024 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728405915; x=1729010715; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbGv50usW4sG38zXcVyQFNaCC2AjNSArZJ6q5XTmSoo=;
        b=JQs3TTnoOqqn/MSbVSnXKbHJObCe290TvPFXoZRh02Qbm7IBRTff5aqp5yvqUnaCcL
         b59sYy64RX4BsvkTz29qMlxlPP7EtXFB70Q10JoILCMMlTrKsCuT7CyRr2S1pypwpoKh
         O5P2cACpM/YoH8o34srdOw/fI8ZXBfUsEPq42FKJS+eXxV5V+KuCuJyUNdh4yHjIjqK8
         P6rbM0EiXO3kXPIwZoVHyc/nDGVT+RL5rY6C8sswg+5wI8PW/Ammz6BArvlSvDiWNtdM
         QRUVDgDogo+Jisb/2sPntly57KWZShxgPKrxx3OPdpjHPH+SWO2j90dJTV66ifrtErWS
         MZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405915; x=1729010715;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbGv50usW4sG38zXcVyQFNaCC2AjNSArZJ6q5XTmSoo=;
        b=iOwT/cvIlr4x7TQTRKNPHf0gUWatzO6MOzMlBU205jttOIUgpbPI7c3+o0afOPL+xc
         QvP2eBerOo//+5Rm+/AUlyAx9UnzPTRwmW1d7tq1GBuImVvDtSaYRsVLxlMpPVEKko84
         v+mfV5gkRfYBRSD8OhPHoroIZdcjwvRGUrOwJuwRTVsnoz5Q7k7DH4Hnz7CktCnAYNHh
         XAw2rGu4UwRp+RMRmVfdfTct/wwrRI0lPUyEuu5Qga5B1YNsXdcQkAc9qpDITT3KrNjU
         UDpgb0JLunWYYLkXDwqqSvfEmdk3wbyJIZxPyV20mxsXXEZ2HfkkiVNSPCddSWybzn9L
         97ig==
X-Gm-Message-State: AOJu0Yx9knAfceLYS+JK0NyqKIiln99XqdxpddlrWvE5MwavCIQSKFcm
	PLEKvygn2Iu0oy5jUQk5khvZA/VVHSN1Qa8cNUt4SBJ4wlb8qhY=
X-Google-Smtp-Source: AGHT+IF81cjb2dtBcsHFbHv1EhdLymg+rKh/ezCPq43L6UrM7quXBA3ad6IY9P9/s80mf0FYbzr1Bw==
X-Received: by 2002:a17:902:e891:b0:20b:8c13:5307 with SMTP id d9443c01a7336-20bff0396b5mr239315295ad.33.1728405915399;
        Tue, 08 Oct 2024 09:45:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.38.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939c3bsm57545175ad.151.2024.10.08.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:45:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
References: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
Message-ID: <f4f143fe-0fe8-45c5-3014-7f8398f2e1bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Oct 2024 16:45:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11239121123

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d11f11dec586
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D896784


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
