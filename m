Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CAA79F0
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 17:33:53 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b04706c974so9002045ad.2
        for <mptcp@lists.linux.dev>; Mon, 29 May 2023 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685381632; x=1687973632;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csouCDCPMcWMEm8TVihVliUfvefBDYdE2sXX5uaJlSk=;
        b=nMidsW0wS6Fxv1x72obwMyOGT3NJNTIulbTeKnBcWAlu59aifyFrwSvwxBJD20InWA
         2cIt+z5+Gk/N3FsbpkP3ZQbS3LKzYg2StH8ZRd+lAKDa0E0yMe0wvf1gZcY6QEqnhsYI
         2SBI1NygBUDJ2WNekgrk18MQt2Pe7WZYnfqIHN9aeiBBGp3hTSlzfQwEkj/xgGmZciTf
         xGvlV3YuL83dNyMtZQgJ1XgsPyT8vs61/tR3e56SgodhGxnd5IsDvuNc9HAxkCrQUxuT
         ZKfZ0S92VxirXLjhdwVkSG805aIrWJaos5NDVIOsIlVQRwPWbjQMVN1SNumj98SnwEIQ
         ZTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685381632; x=1687973632;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csouCDCPMcWMEm8TVihVliUfvefBDYdE2sXX5uaJlSk=;
        b=gT67+DpyUGQciPCmW1rQ3d6h2wcf8tYSyzHcAGcWsvr57RXwzy5n7yAeSfQPw+nOpt
         NNCi7oZUg+sCAz/G15U1JPbICBCkuQMYBG85+kCV4RvqH0LdH8OwXqMW0OnGZ7PIds7V
         rrvNHx5LtIm07JGbU8oaAXIuuYPkj1X26HGrxcjwnqWp6MQkm3xKzBgajY2VKlwDVi3S
         9QtHzHbe8ZebADZ8bbCwu036Z7hGv2YF5qweCqiH9bdNYvF2SxGWwEkp4T4XswvR3SqR
         7gXjO+AdyfuvWyU/IE8q7hG7qgL021QEyqeqyOWpmw46Y7kAyBe/zuce7fZZSU2RFlpG
         +Fdw==
X-Gm-Message-State: AC+VfDywKA1Pwz6PIU5FIUK+V0mLoKcuvO45vqH+ebq6Recd98y4PLyD
	9Cfq2j811qbwoPpZ7l8rUg==
X-Google-Smtp-Source: ACHHUZ6KmD3zjvNOzeLZaKIuC4OOn7qJuhSEssu9lAUsGFMxEIUZdLWX2aes/jQIV87f8CFPhVXQew==
X-Received: by 2002:a17:902:6505:b0:1b0:3742:e732 with SMTP id b5-20020a170902650500b001b03742e732mr5395984plk.23.1685381632459;
        Mon, 29 May 2023 10:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.13.83])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b001aaf92130afsm8538031plg.116.2023.05.29.10.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 10:33:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
References:
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible divide by zero in recvmsg(): Build Failure
Message-ID: <b2eb3a30-71da-e034-7cec-2a6bf45bebdc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 May 2023 17:33:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/5113790043

Status: cancelled
Initiator: matttbe
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2dfdc2932f=
2e

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
