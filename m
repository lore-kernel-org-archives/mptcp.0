Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CAFC1C
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619128; cv=none; b=ZLYps/1CQTKLhYXQFvuhLDqfp7V+CrDLWMEdI6KlDkQjt76NWSt+LMj1ioRrNBE3kLpgImMA4G7UoAFIxvYG2EsOeKABBSi7lFY0yUTWy+WrnhY2zetq/mYUX1HQ6Rxh7URwREmtz5DJyjwLstD7eC/dlUuMU+GHM56I7N1GxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619128; c=relaxed/simple;
	bh=psCxW10Kq5PrwsMO9ovt2CbOx6TPfNiTCztWOTMoe1w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Vh0yeamkRc43AnB2UqF6Kk7OeJ/jP5/+MF8dtiG13CaFQMl2fGrtcPx8U8vJCFMaCjZ3W+FLJ0s2liGlyjRrk+pmQTDVKXUQHcI7MUHynJTeq3e280FXPCkYuoZ4103S6RG7hZpUYsBE0QLrO4BecRWe95HDYk08NadYetLmUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJc0CKny; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJc0CKny"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7881f80b2aeso19935485a.3
        for <mptcp@lists.linux.dev>; Mon, 04 Mar 2024 22:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709619126; x=1710223926; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8KUTgVvRnsyt8fzj7LEWbn4Ybusg27T3qbEGRtd9Z4=;
        b=iJc0CKnyeS2relXAUZkPk0l6yr0PqTQgwu3lIp7DYTBOOXQ066pfkDzq3TasYa/7gR
         qbntmvv/a1fVN89gwA7C86SAAh4dmxxdS2+4kIFOfaNFtkKQG/JqnHc8+gQzQquvy6HN
         63kVz1lEwEkV9rR2d8CGoAIDwLHWeuoGK7DkS5Hj+vQCoz+SiQ0nuYy3dEBbPBC6T1dV
         Xp03rbe7lypxfMkGqeNQRG2ND4nmSRt5gAviLTPiD0IdSYbcMYoXSL2vsqP07kQ6Q5Xk
         /tWlEOqMtvI1BoipUnS9Ips/u/7+fSkGRf475wmNub6RP8bfi93lMw/Gsc48Y9/BCpUU
         Mkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709619126; x=1710223926;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8KUTgVvRnsyt8fzj7LEWbn4Ybusg27T3qbEGRtd9Z4=;
        b=rVfyr3BWhAG2XWyBbGSiTGgDzoZrT4PqB/oj035GhCACQs2FdDpDdQXw3pYGGg5INC
         z2wRRRoO+OIB86XJKzJaA1LTGMonhmmTymSXxGVICnOwcLB2cr5O4j3ajWqowJTYYZui
         eyloeoR/8nLMfIwXF/47kYDCrf9SHRnBz9gQ739NsZ1/AzdQVAlySaj9gPQNFDvANWGb
         Lkn4Fa8fFm/ju9GFmO5JvzgoXhbe1fBH28zVW6SUYBk0UZfj5okK32BHgrzYA/+UhV2V
         LqqPOSZtXDZwsz0FyBY10WfOeM+G91xUOjbrhccnQIXO+aSWMzahydfA+z+lAk5+wXQN
         Efpw==
X-Gm-Message-State: AOJu0YwaCw4aprjTE1XhAqfP6S3f4Gk/FF9nZsygu50XnTakWb4BkmOy
	HYWns2muJwW4mZUvYof5MeD88CljYNbhumsDT87eLvnbxeQxkiD2ODDEAnI=
X-Google-Smtp-Source: AGHT+IEF8M+KFOEE0Y9g1gQxBC1QL19IrKbRL41YwmU9+IyU6OaqW6NjqqHeEhLTmMGZUpDFTPa5NQ==
X-Received: by 2002:ae9:e60a:0:b0:788:384e:9a7d with SMTP id z10-20020ae9e60a000000b00788384e9a7dmr43200qkf.22.1709619126041;
        Mon, 04 Mar 2024 22:12:06 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.35])
        by smtp.gmail.com with ESMTPSA id a17-20020a05620a125100b007881f769315sm2708043qkl.68.2024.03.04.22.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 22:12:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
References:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <4a6c3621-0146-c524-cdd5-fe7e8a25f2a4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 06:12:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8151=
544558

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e3e5f8571998


If there are some issues, you can reproduce them using the same environment=
 as
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
