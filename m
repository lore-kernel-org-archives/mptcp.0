Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6A37F759
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891918; cv=pass; b=tIDt2hORbkdgcaqXZeaB2c3rI5ngOj+TObUluHSSTezBih0nIOjzzkMTsKl+lF2wsbUV8d6KXDreTCcFpsBLa3bquaXgTkLYz4jJiFC4ggtf3DwoHfL0mskwQ5VBAXvqL8R7LVk2883/SsILZUcljDuDJD1qnbEOFKYZQ7IX9Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891918; c=relaxed/simple;
	bh=2PlGsP2/WPwzOTDoxJ7ZLndPS9AeRttIrMMtUBu3E3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJZKi3QbBNTonJovMdeuoQPpmUVKLdMkNvN3u5vPBEUyuuNPOztBjMbYN5Lk+xqafYE/OxYJkDnj1ITBSspIXoxB+fPJV8aLNuEnv8hG5/j97lE10Bh0IPsPICzPZpRMjI7jbG/stpnmZhsyiYoQcAjsPiZXQW50MC2sUtB8OYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz3e7mzp; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz3e7mzp"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4303eb92930so2463038fac.3
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 03:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777891915; cv=none;
        d=google.com; s=arc-20240605;
        b=Ew3L4CN+clbcix9FbOUxw8WbaKTLwjiJeISaTBhtQYdzdCSeEHMTIc3vnVhg2R4HeD
         mnNMLMFAWBNEN/lszsDzAHzO/2malaSMaUdPgk3Kp2ysHFaCPa5/ZlarjM2PdpZGxKWS
         xKZFrTCoVTWhIT8CYz/neV0E9GjKMzpsl8j2tgaXJcpzBHzUM8t/8G/KmzqzTb4aqO8d
         rO8YyWnLRNJ3SWWZWBjzyEoYAo/O2ei6A+Xiu8OL+7MHTCs42sSOMijhegB2LLzesBz7
         apiN/UX6eXQwaSQblLTYyzlyI26+EO8646TGatZqJmrh2pMVJHsboIlbwiyQNEtQwYoN
         nYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2PlGsP2/WPwzOTDoxJ7ZLndPS9AeRttIrMMtUBu3E3s=;
        fh=uOgxwBv/G00xChfAXgYBX18fjEAiKqASTCSINK036KA=;
        b=kQCO/vEROOZCD+p25cqy4zx6KSSRmXcSMrABWa/PzxhhmKBrmBMvLlNBDNWOSa5h2H
         Nt6EbIxZgf8Vlbm4RmeI+dXiVvI6HK8sqHROz3mk3Mfx5jZtq8yPnX5XpT+XEh2Q2puf
         MAo4gr5sXgKnBikMjVW6yV0TOqGcpPZ92dufa/IsY0YPONf/VKs02vIYsdoLcsJ8rmT9
         M5E3LqpkiP4hRqWXlGc35x4Tl7yLRZN3tr3n/o7DM0cpgrg3JUYXRXOLUklXxe/AkwMa
         5fHgtynbKrh1bTU0T1if+lN8gc+cZ+i5UwPB29jhgOhG3H2oZMBMQd/+6J+8Ic+ip5A4
         QEOA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777891915; x=1778496715; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2PlGsP2/WPwzOTDoxJ7ZLndPS9AeRttIrMMtUBu3E3s=;
        b=Rz3e7mzpIBlGsFoS/L+2cboh9nZpmlPR6w2nkfTOcy7qBt8vSKYfIGDlW1iXMFycIB
         V5ZmDsD5Nue0IL7oTwanygqSqw9nR165vPbetoHEU04Pw2OHHNYdPoRymTBarsOZ0AgJ
         Jis27KflkantwL66x0r9rQjYpkEn/NuscZ90Q6whHSe/esuEjrs50iznHhL6fG67kWmi
         E0oE5FcaEa75B5sxbEQdVaHHi0D/dsLsii0oc4speRd0u5xOygqYiHTO4ERpH3PDfF2G
         JKPRTOXUgKHFdVo6DgNXqgEYNbiHIx1W6qc08+q+tPlOdDgUOw8SWmRDJMUoRqTIJRVL
         7CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777891915; x=1778496715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PlGsP2/WPwzOTDoxJ7ZLndPS9AeRttIrMMtUBu3E3s=;
        b=hOQKGT9rgrv5fOSdbknHjfSEODzv0a1ll+RZIzxjCpfEpUowoVm6pQT8BRcmZE96XR
         IUaY/HOoYyNfsCqlmE+WmUNOaSlq6CZjl4p+3iLgJlqjrfnYan5922ediZYqAfeRZTPQ
         lgidZZ7ivlobaLuEfsTV8KDImz/L5GeDTruHCbQAxRa/UKotr8OiSku38Iyw+CFGMVZT
         i28wbbJhwps5cwTnCNyG/bwbzr0zelqLVnUnElLHSjd3aeFIguKU9SsIugG3Qq+TQTyJ
         U3FFuTSia0pUHgCPX/9tqMgaA1/jrFB5aAP+vAB9oYC7VC6CbZ9vCo65WdUhuCaDFm0h
         ZVpg==
X-Gm-Message-State: AOJu0YznFrdjoXZq0wDrSf/YMgfGT/rktxwZC+8WW+i+bAfXKpZJNplQ
	q08m1WARGz4y2dNSyfOvOSKfwymiVKyGpJtSxED4/RbrT5Oky683W3qfiQiMQYQQ31Ct92IiCKr
	H6hXw3r63NogFrnsnK7lwYpi46Z3QqwA=
X-Gm-Gg: AeBDieu8g0wLO6PPe2s4vbK5V5C+kjdBEjE+Dk+rjT4UuuUUOThUmsQcNDBF5bZBxf2
	zIY5EIoqVLvkhVxcoH10j0aaSZpQi0lnVD1EpQx1pEFNT+lXF9WPvdq86lD7vcO2BMXF/hgaPBY
	s1VZR2jJBpwFlDaNhWk/L/c4JMgKEgdIRCLHbGLs19BCDe0afHRtxDwOMUCMt7S2oZ4fVYqMdol
	H15awbb9oBlQKVPutvauTOszJLRZS9YTNWzhsXjrKQqbtUtxtF5DEx12xIf03hwl0vdFewyIo4r
	heZ7TrZIb0LEUhWRz3HqmAkgOqWQnmkh96kiJRbMu+It5vNZ
X-Received: by 2002:a05:6870:2496:b0:42f:ef25:47ee with SMTP id
 586e51a60fabf-434760c5c53mr4962483fac.16.1777891915552; Mon, 04 May 2026
 03:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1777756707.git.devnexen@gmail.com> <d06ddfbe-96a5-48f5-9ef5-b7892423b9e6@kernel.org>
In-Reply-To: <d06ddfbe-96a5-48f5-9ef5-b7892423b9e6@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 4 May 2026 11:51:42 +0100
X-Gm-Features: AVHnY4IPKVoy-3oKOrtUSB5pxry3QSDvLCgIAV4h5AJz1vfGSXsshFrlwYECD9w
Message-ID: <CA+XhMqw4VP04QQhPisy4BfvWqOTdcBy1FGsKTTKRACMZTBvw1Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi and thanks ok doing it locally too indeed so many conflicts :)
Regards.

On Mon, 4 May 2026 at 11:13, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 02/05/2026 23:19, David Carlier wrote:
>
> (...)
>
> > Changes in v5:
>
> Thank you for the v5. Please note that the CI was not able to apply it
> [1], because your patch was based on an old version of the export (or
> export-net, for-review, for-review-net) branches. I manually solved the
> conflicts and sent it to our repo, for our CI to test it.
>
> [1]
> https://patchew.org/MPTCP/cover.1777756707.git.devnexen@gmail.com/logs/git/
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
