Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9E303A21
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446793; cv=none; b=TkcB5xKAwIvRxNMXLckLMTRE4ZC/08OSoEnsdVhlnVVXqLS1Rs9POZV+m5R0ACcIzPUx31q1SaX71W59NTN3q9ANDx4Ij8dEdGleM3uszwkX5pIgdruC0YHPKmkcxwN7vRrtB9s+kUYSnJfsXN+/auqp4+S0M+cj08QV+Ep0QRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446793; c=relaxed/simple;
	bh=3f/TSBzg3Um05bYdruNCGtqstquMGTv5ISbchsJb554=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sP+iTd8r1QwtugSVrDQc8x0opSub4TzeDomVXmsiyuKX17qS/Q8VH1Y7/uBoCA2YGzpUTr/rOEICoddAMKVuNrMkWUCv6v6wTM9rBzwRMjLxxHMWinPl+Mwbhp791HH1CPLqpxxwkBn7v5CMLBTxIHxwse+/wx1r0NYOPdahQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZINhoHY4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZINhoHY4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5f6ad78e4so37863941cf.1
        for <mptcp@lists.linux.dev>; Tue, 09 Sep 2025 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757446791; x=1758051591; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+1UAsJhlB5l7JaFoHJiHO2vxcan8Mh599KAC0ETb5o=;
        b=ZINhoHY49M+LFitqceOVLKOAcWG6GzeR1sKe+m+J2FPfkL8nH8bxyD7TMjuUYyCtkQ
         S2KG6z8uMWnt5mWIhK2jGUysjVpHTKwRznC5BScf8o2RZ9VdmySAwhiSi5j+Gq8NLwWm
         YMBFSR4YWAIsaY86I1Pcvqjt7QUG92VGvDDUWXZuFi/93Mu6pO+h/ACfFsjd/712Gof0
         t6z4Zlm+h3NjaqKRkKDhDFu3fJjSKl6al2YU6BDdtPgXFFLbd5vPItbXvjgrPQ8fADd1
         l0InpJB7ANyl/LmDDG2uZE9p774VLhlFPnKPkIs1yOt3Dc7m6esP3ezodgQcJTpmHo0m
         dWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757446791; x=1758051591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+1UAsJhlB5l7JaFoHJiHO2vxcan8Mh599KAC0ETb5o=;
        b=obQ3fXJv62bEJhSiJOT6E+t5V5qA2tO0AcVw8Hn+qwKvoiqgeOfTtATE7H57OMuh67
         r/RqkgY3s8DlAkAJeov5Jl+7MbluHMKV8gT9ZyfFJEcaYVtmOlXUjUUiKhsUUWqTkHmM
         nm4vv2+AV7366zwaKApwx8rdNSiFV7UfBl5p/knTG5pqrdmOpqG2DiUUyA9CmU1R0pYu
         RsB3E/vsUk9QVFWsQFLuQ9X+5jhcHbuI+pYeUQpxliBJ4nfF6XJJd9FbG7iOJ8j7m08y
         6XGdrAqebVpeNZQ+LrMML8CHh9TVmo9vDbSvqjjRPxHF5HEcMmDs4oY9SNTzrj4Pj09D
         ZGpQ==
X-Gm-Message-State: AOJu0YyX3WV4mWGR2kucaoYiWC5ITeL87oZiUnK9uXF9ihRh5zeJ17Gf
	oPAULC0M3jWkVPSqQ/5qeKT1bBmQuS3VBE1Q8zVqa9VR+PunI2wwlhfXmM2+
X-Gm-Gg: ASbGncv+j75V7OfoEQ3V7QSD60Iq7WrBUxsS+qzamb8qw2KL2E7NX3HrqOHJBshvSd0
	OLTeI+IHTPfohZypmWEKbWbW0trKSNBkqk+BKitJUFrSbq2uD4MCdwdv+PsJAR4ZWuxOk/XnvMZ
	bxuTyyjC4JgjduTi3Sm8zNqtvzYpag0TDGccmYb/oTbQcmUwhd/bkWP2xXwzQTDeWE638Te5cwO
	gaG18bipLVs/Ff56x8yXDCgJIZQNwY1quEOSTlU+mhNfgJqEM5Z0zMfOg5kVjegUd87j6gTOTR+
	vldFF60pVHPLhJ3DwEoXLhqxQSU0cXF6IS/sQdeVjzIYPkLJsyaujmYPi+ABhKSnM3cHWFY9Dyq
	zk2t2gSri+5iiNy+n/WwA3VrN7t7X7VNTTio=
X-Google-Smtp-Source: AGHT+IFWmkbtzWTLufZkNXATpGM6bX7oM9qvHScOrSMzSV1Y4OnHL85gk/y1KOUBWEQdie0gaM/FDA==
X-Received: by 2002:a05:622a:24f:b0:4b3:10f0:15ba with SMTP id d75a77b69052e-4b5f84472e5mr151868041cf.39.1757446790716;
        Tue, 09 Sep 2025 12:39:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.38.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61bbe0a85sm13413511cf.42.2025.09.09.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:39:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org>
References: <20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org>
Subject: Re: [PATCH net-next] doc: mptcp: fix Netlink specs link
Message-ID: <6dc046fa-aca0-2b5d-d513-e6be41362a83@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 19:39:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17591544452

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d69a5d5874a1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1000651


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
