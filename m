Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6868
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 20:21:06 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 7so7641268oip.12
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=kjmF+ozHonvp6kdpHAqX2+X5xhM/4bBR9oHWX4ar8ew=;
        b=U7vXgC/y29YSgoGY55gplLpMHhI3S4T8/TnslyGZskhBm7YdaNmPrK18FuuS4+O8YB
         4X8y9xL5JFOH2At0sGKofB6rg9XymQnxKrfXaZo7e+8Q6q01Y1UY7gAiy0mESz8tlFwm
         EOvOxSuf7PV7PvPoGjws0Ah9Nb3ba30GC2UaBQrfPCN4dBHM4xgWXmLCmv05O26BQ/Gh
         jOw3EEHVP2HvyGPhMAbtdB1eLQDlcntWYB97+UVa4yQBnAyNOz5nLaGXpkeryARy3U9T
         gWg1kuDVa3AvFf8Ldk7f0rCioPKZLEfjUaL5R3sEOLLEjos4OugRaoNr7sR6MOGc+zUc
         cMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=kjmF+ozHonvp6kdpHAqX2+X5xhM/4bBR9oHWX4ar8ew=;
        b=vnWtn2CLPgXFpqCeliO8FfnDSAkorPMJjGWqmSgegGTqi3Uen2F25lMP/qKpSHZWCd
         2zug5q46oZcGpE5hR7rBwGcHQeIAgwQ7cfIt+2I7XEMqUIrNglebjYrISjAAHSzd4Hyj
         qBc41urRhm2SpemG0fGm+/zAynqyOyKkK00ic10b5DEYlSy+2cOgltuZsQc7soLuhtzI
         sJ0ESdBHtB7DkmZdWKguURC1revmYoC7u/oLVMx64YiOmaF+CCkK07IGwRxaGoig/rIE
         wsQZO4CjVoFMus/qI36xdKZGdDOs1PBKudARfGRDdOqy6lCIe2iAmrixC5JloAsKPNhf
         09wA==
X-Gm-Message-State: AOAM5301/HkA1T6dBW4gHWSi1KfLXQsONLmua2cKS8Q9kK0DxbOcIR1c
	iMM0iLKw20BSkCnO6jGzBw==
X-Google-Smtp-Source: ABdhPJykzZs5etyifUgp3fniCGE+cLxvLPZY/gdsFREzKXbXRoTnlwxfGzIasaQFRdzcWr/Cxs38Uw==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr9330531oie.123.1637785265612;
        Wed, 24 Nov 2021 12:21:05 -0800 (PST)
Received: from [127.0.0.1] ([157.55.80.28])
        by smtp.gmail.com with ESMTPSA id e14sm163826oie.7.2021.11.24.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:21:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <44593f9acfe286b9d18973e13877c1e48a15706c.1637770883.git.pabeni@redhat.com>
References:
 <44593f9acfe286b9d18973e13877c1e48a15706c.1637770883.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add tests for subflow creation failure:
 Build Failure
Message-ID: <8367f9e5-2d14-2cd0-621e-d3cebedad680@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Nov 2021 20:21:04 +0000
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
org/project/mptcp/patch/44593f9acfe286b9d18973e13877c1e48a15706c.1637770883=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/1501022122

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/37cb636d6d=
72

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
