Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52042182B8
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 17:31:05 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-76c64ddee11so57815539f.2
        for <mptcp@lists.linux.dev>; Thu, 18 May 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684431064; x=1687023064;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unEA8j1Z/XtzDW00WvxILxWSERjKs2Bri2FOxXv5n8w=;
        b=AiGGCD8KJCZpFbLOGbX13alUQPCrytqow4yiorPaSMu5DIzjiRd3BmtozqV3I7zTzT
         dvt34kY2+DKLnYCIqQTwdsa61bHY2SFYwd5OAZarwvW5YhRDRoaoy5HtGCjhhVI4OhdQ
         Fcfh1CbTDZz/PfaLUoABqR6KeA8qRiPjj3akzWAF/sxauOErKqNZfoqw3wwbnTlr293M
         y7bVOn7mp30nB7vb1XpY/VjPbs75bih3oNWJB1vg0clQOLestEuPNkGqAoHN3PJzTBhl
         Gp5HZXAwlmEE95k70UQtbVdDwZlGphZrylHAczRbEHh4LGsFNZJZmYPNDTM75A3SoC0o
         pJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431064; x=1687023064;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unEA8j1Z/XtzDW00WvxILxWSERjKs2Bri2FOxXv5n8w=;
        b=ReE7RBD2miDmToE6X0nYTJdFe//6nuZHVzkw09bygbWD4XQod00Mx93mdnas/Ykyi6
         UaoZQL9bdiC/XMFYgmBcpT6zUVEVuJHwWogxG9wtor9L9PZbRPIlRAWIKJDMKhoi3LJA
         7bO6YKLmUPQ+Sxch7yNaMMOVbEXIrErRHFHP0jSn2CY/I2q3SyO2tbgca+uqHx0KtDHy
         j3BRzsJbos/3oRP/b74LLhVzXLU44n1VwXL7zXmQNU2+e88v6ROcrHc6QkXNhyjIIClJ
         YvPKCU/3quhbp1KCXKClKCsxLy7KQwF+VrB1XtNCztUojv0FtPzeZWSpAlTfODQY4dq3
         gfBA==
X-Gm-Message-State: AC+VfDzMqSdjpwhTDfCVjC0U/2SvPTRpDG1sKxVIvKPVX0GdQsRkcv5N
	GrpoAEFO3ID2XBN4wnXXNUZV9sj7KcjY
X-Google-Smtp-Source: ACHHUZ4LmsVv2/1HMgr0IciAjTX9MLCCf+MPm0MrUIoNSE09g9VIaPe1C8CSw4kWZZF7JfGEfy2Vuw==
X-Received: by 2002:a92:d1c5:0:b0:325:b96e:6701 with SMTP id u5-20020a92d1c5000000b00325b96e6701mr5031875ilg.2.1684431064291;
        Thu, 18 May 2023 10:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.242.102])
        by smtp.gmail.com with ESMTPSA id r10-20020a056638130a00b00416669ff308sm565237jad.37.2023.05.18.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:31:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
References:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
Subject: Re: mptcp: fix active subflow finalization.: Build Failure
Message-ID: <9cdc6ccf-3529-8fad-5a49-4c1fd8d6feeb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 May 2023 17:31:03 +0000
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
org/project/mptcp/patch/41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/5016483061

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/857e3bf32c=
8f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
