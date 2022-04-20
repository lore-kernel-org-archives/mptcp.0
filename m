Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9EB7A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 05:14:43 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id 125so695867iov.10
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 22:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=bilrtmBfnUCCMI5wwZDGeAgVztRxHI/gy9BIy7AK2lE=;
        b=Ta/vqbNZ4ykpyzMrm7INLouoYXwt0EJHVaRCQbyHsyKvu3PDpAQIzU+Sa8LlEMJAwM
         HBS8xHgUwT2WUpUa8Glb/vGGn+K/tqaL6eSi+JVLjXMLUIEVUByEnMfiHgdOBF+4Z5FL
         hf4IN7sh5cgVLRN3qAXEyBwP/ES37JOT0y3sAc+6oXjLDN/7zGbwvPU+0WdY//7Lx8Hh
         nlkQdLaOvBceuIjtP/I/UXn7fu2z1/rYWX4Ln+SSWJZmKnIu3oKsXedhuBCOc1V588a4
         HFx07p71DJ9I0rEbe6rm2zTgiTIQsVFOSfileNUTpU1fIrWLluNUfyOI16oJDeF0b1zU
         5SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=bilrtmBfnUCCMI5wwZDGeAgVztRxHI/gy9BIy7AK2lE=;
        b=35GrPLVeuMoRtANlux0qqBy2O5EeFbibYRE7495e8Sk72MqdKmTkxvEfUtACEOZbXg
         qgq2/8e9oyxMoYn583NY0vaQR29qwCVPUDdEqixMM7yNWBvesm3bXbNP83lqnHpdfsTG
         Jcv6NWt8IlUFfhT+VYBcHSN4AEddumXmyH3DeeaDi17BC1pSW7Dci555e4NXORKeeVlY
         erEKk+KgwCGtGjwCtJV5iPhQiuAxUFEB6vLy41ZRlj2hmMuOqMJiVEmUZ/Ho5TeWax7H
         Dot78C9GGb0TeGNhS4aIkvVhw9IhBUl1wVG/p23X6nD1qJCYZ0exyMFY+dshgRmWg87x
         H5/g==
X-Gm-Message-State: AOAM532IhexsuUh060+cCF0cU4fAi9LviYJF/jsCySbgZHqSq9zk9j/U
	Tb+pG7JwKagu8m2qTN6aKYADikI/CQ==
X-Google-Smtp-Source: ABdhPJzyg4IC4Eu9mVxw0vhga+OGMj05qrbUaolCVexKxJ8bM80TiWXdbcYPJ8vIYpkUTKBgkAh7ng==
X-Received: by 2002:a02:c50b:0:b0:32a:6fd4:65d1 with SMTP id s11-20020a02c50b000000b0032a6fd465d1mr3293705jam.88.1650431682526;
        Tue, 19 Apr 2022 22:14:42 -0700 (PDT)
Received: from [127.0.0.1] ([104.43.212.89])
        by smtp.gmail.com with ESMTPSA id m4-20020a0566022e8400b006463059bf2fsm11204773iow.49.2022.04.19.22.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 22:14:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7072b5ca4b8e6d710506a789c4e962c9e33cc54d.1650430389.git.geliang.tang@suse.com>
References:
 <7072b5ca4b8e6d710506a789c4e962c9e33cc54d.1650430389.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Build Failure
Message-ID: <ee9453e7-0a07-dab8-83f9-827c4552dc73@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Apr 2022 05:14:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/7072b5ca4b8e6d710506a789c4e962c9e33cc54d.1650430389=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2193665679

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/cd43e2aef0=
3f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
