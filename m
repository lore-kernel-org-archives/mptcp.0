Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CB2C9B
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:59:23 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id az8so8361797qkb.2
        for <mptcp@lists.linux.dev>; Fri, 05 Nov 2021 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=1qdJkMs9ZMHBL9d3+zJcMu92s14we7TZ3vAVwI5ZeYw=;
        b=Qj4hb8xiv3WbXqa6fazTmQFVuWkVV8LGzU6x6Vk6Jizlb/1v7AZ16RTSpYl+eoW3ta
         qOKym9a/v/RkveMqWAcUPEDWwBOJqlMHxnWj/QLgXN1pm86vRt7qWpxDSPnZQVSy8jax
         FSCFbpjSxj2S7gpoZiRGISck9Z7EHcJxYQBSkcW3mw3OyxpYWgjRRXUY7YxfRoMb8Lmz
         iT9DSzPXbph8MtX1cTQt5ZMqaTnlFX2BxeuOjVtoKa86s8dAt+KBnUf/jDL4A1YtC6ma
         UDRcCXk7T3cFq+iaFvWsOT7NQCAUWRUy+8tDcAAYcQSpKS1unsr9V165ZX4G7HIBAZDN
         VLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=1qdJkMs9ZMHBL9d3+zJcMu92s14we7TZ3vAVwI5ZeYw=;
        b=36/c8dBAqhRRaJ0M5ZaoGot9lFcyQCSTw6G003TD41E4P8bQT2gQl+Cjp8yLBmZoiN
         HzHTF7a/VZrip4t2B5sA8g0SwZepU4jLOH33s4eM3HRJFGMxWAlDJpQP+R0SY629IpnY
         4Sy9CdPITQqnJqHYXdrp2DxsGkyQPx430h+iyk+Kfaz4gOjkx4D+er/g9/q+EAU8O2hy
         0275R4rp/mRRHAWv+kIqsN9a2BXDrS15YJtKTxKpIStDFfdSfki4y1M921jh9uhrqCzz
         YdvBFBRm1UHLsXA7Y8gczwR6sLGpXWYXjOSX9IfOKlw+4kQiIUTsf6elo22doK9xmwEv
         HOdw==
X-Gm-Message-State: AOAM530WxPZyxVmcPSNj+iDKUage16wzotejSsIqSOgcN2AIJfhQhaPh
	GxYU9AydaKWfswoRsTJSzOSrTytvGQ==
X-Google-Smtp-Source: ABdhPJyoX7NckKkEgtj3c4NPk+vSVJ2r1vT9Q+ywn0L/JSllOP+z0eM8hr7SltfqbAbGWNgtnWGy/A==
X-Received: by 2002:a37:58c4:: with SMTP id m187mr45921307qkb.481.1636109963099;
        Fri, 05 Nov 2021 03:59:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.114.129.100])
        by smtp.gmail.com with ESMTPSA id s1sm300947qkp.55.2021.11.05.03.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:59:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bcf5c3220ac27570e942835d97b4b10b8e448eb8.1636107361.git.pabeni@redhat.com>
References:
 <bcf5c3220ac27570e942835d97b4b10b8e448eb8.1636107361.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup accept and poll: Build Failure
Message-ID: <9335b46e-9e3b-e99e-d21c-8a633465bede@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Nov 2021 10:59:22 +0000
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
org/project/mptcp/patch/bcf5c3220ac27570e942835d97b4b10b8e448eb8.1636107361=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/1425370804

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f9fa79e12d=
45

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
