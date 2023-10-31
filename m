Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD811DFDF
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI0h4mrk"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41cda69486eso41538721cf.3
        for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766315; x=1699371115; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEdwKaJiBhOAkquOpS0No1mBEq+xwiedCIPdvb+gssY=;
        b=dI0h4mrkQ+uABOOsHk1dN4ugn6EPFuJy7vKhrRQAT5nvAmdKgp0kGW2htu9+UywLG8
         aL8/LjzjPlXHvOjik7S31hG7BX/NwHVxkeHLX1K1HcFL9k7NdVSA0gsewWa+Fh5bVj0n
         QHPsT6DSYM6Rz2RpA60c7NaUVPu+6wrPe6eY8f96DuQuULEFnoQJqVime5cuAkAAKSsT
         6rvuuA0zRQIkBEUpcN4aMi3EjrZlRJ9CuR+L+amIoIgdNn7rNQp2z+445Nx7rgHS7dsm
         6dkiuCo3T6S0ePaZTABbN4+Vbrmg0lhkHMnE3E8l9goCL+kGx/u0S5vWryCAB8CsVxPS
         iqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766315; x=1699371115;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEdwKaJiBhOAkquOpS0No1mBEq+xwiedCIPdvb+gssY=;
        b=tUw1UcsphfE3Fu0dkbeNOo49tgsg+rWEKtSwl2WHPPlFj2dW0QO0AuAwWHNI/lLd8J
         uXs3Ix9jElXy2w+Suq8KAQ8WibpnPTZHMcwMzeiZLLfl8wJk6e7kHUtMMnWtkj4qmUs9
         i8FfijNhc/myLmS3R3xnxy5lr92l7Sxzf/xsGxZeGXHMHSEE4xQmGemRONAWiHkzEewj
         eGjfcxTVW8nEEtyFDMnYwyDyjBjdqEn6bNe9/z3Xr3XTN6VkPQXzOSSJwpJZ5HQeBNu7
         ft+psmp+HSB6aBMWa0ghn3azsEpvdpno/WnQCyKZpCVtmRA2TaI11aTbqX4f8IKdiH1h
         7OlA==
X-Gm-Message-State: AOJu0YwZbzY0GdVpwJa1U+xW9/7+4BOyD3XCCD+5r2U4TbQmZlL33JKl
	0DbaUIrxDGSVCr3TbAbyIw==
X-Google-Smtp-Source: AGHT+IFCgSPs3k1tHKFdmuxiUoYj1jXeDHxbpF3cdkoLhyqQoIbGPBBw9hM6XDC+QYJBuTRxjK7HkA==
X-Received: by 2002:a05:622a:315:b0:412:288f:3853 with SMTP id q21-20020a05622a031500b00412288f3853mr16191679qtw.28.1698766315397;
        Tue, 31 Oct 2023 08:31:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.44.76])
        by smtp.gmail.com with ESMTPSA id r24-20020ac87ef8000000b0041b83654af9sm581304qtc.30.2023.10.31.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:31:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
References:
 <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
Subject: Re: net/mptcp: don't overwrite sock_ops in mptcp_is_tcpsk(): Build
 Failure
Message-ID: <a8a904bb-c84d-7fcd-b04b-afbd7d810768@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Oct 2023 15:31:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762=
.git.dcaratti@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/6708756766

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ece97d6ac3=
60

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
