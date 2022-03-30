Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AE258E
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 17:00:05 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id t2so19311155pfj.10
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=H0oTS5hLIbKKVc7CyCmdenBkSyB4F3MtErqEneOhu+M=;
        b=kOoqKeFcyBd9/falzKkt3bfCFUr+k8GyYKu20SWKU+ST3sydnY4xfKZQ4Zo1ETClso
         BSNP9dPSvsisjdJjmrTRMUYqqaZZMXdGvfSSVXG3dBznLZ+iHktzGiSvvEQPfMUR7YTh
         DuV4/MLf9d9JcKcjA3goIssa0N7ChEgLhofjLzaflwQpBKV8+nD+js2+EFFUseARcAke
         sJ5PwZubpYspdc8fIQ++WQO39JcZplynKTq7pBxdv3I5aZdsUGnu0C7/nnMwapsUgVe+
         8ZpHRUVLQT/vRU7ksg1epSAdqFGHEOTIxp3bN21Pf0p9FaWEiyUS1FJXNujzW8bGEq9h
         gmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=H0oTS5hLIbKKVc7CyCmdenBkSyB4F3MtErqEneOhu+M=;
        b=u8x/jr/T+Mt9hEqFM3ZZoVB0q9JCsa4FJl5oZhc99NsJMIksHqTFIfMobUzL/LYSMM
         XhvsoOy4GNcF3y6mlm6uXvA9Md0QuTaGsPhNG48FDa1l0/5Fp/uN5z4u7qZN8XnKxuD6
         g5a1gNfhdpex4e6W+x2DURCosrEWH0KWFC/FF8WjzdSatO3qzJziaP/ac3SVxzv8iF0A
         ulLIFOsaI5/YzssAwj8GYig8wSsc2GC9y6d1pGWcu5ASUhvINdXGyJM969rjXI6JQAGF
         S1/YlLrLI9U9O932YJq7weyWftjfKYO4eDpwg7PIQG4UcGya+ITS5UqOpudAlEqRdUiU
         8lmg==
X-Gm-Message-State: AOAM5324hWuC85/ywVzYAhCOc+mwn43WpOLzsHBKcnPZfWOdjzLJFi+i
	kkB4f8ufrhNICaY7824N+4XAMkDjUPgl
X-Google-Smtp-Source: ABdhPJxV+7eLSm0P5MehBj30nrTWw3sxOgLgjdhuFRKKReZZG1lxjf/9UbYVOA+LHAKVkMdA5UJPbA==
X-Received: by 2002:a63:7b4a:0:b0:398:1337:e304 with SMTP id k10-20020a637b4a000000b003981337e304mr6971880pgn.371.1648659604185;
        Wed, 30 Mar 2022 10:00:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.253.253])
        by smtp.gmail.com with ESMTPSA id u204-20020a6279d5000000b004fa58625a80sm24218619pfc.53.2022.03.30.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:00:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220329021401.1196466-7-kishen.maloor@intel.com>
References: <20220329021401.1196466-7-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Build Failure
Message-ID: <020eaa0d-a0ad-2a20-60d6-c49ba25976d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 17:00:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220329021401.1196466-7-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2066164177

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a130a46e54f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
