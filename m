Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DE2C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:35:44 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id p12so4617195qvj.6
        for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 14:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=USqYZkTz+gPkFo3EdrrUS721AawrRMxTCxHqTqY66wk=;
        b=dP+bJfiJUsjgWO7ePCa+jczPu9zlFngeU9HQXVRWnsAZu+m72scf8E+7h3NsPfX2xm
         y+3GPyjgD2QElUTGYSKAtWzPDgcVuGcUIlwJFqmSqgkCv1NfolpwLzCoAODowexhVnPV
         5axagP7JxNLS1f3E1t/9WWvkdIQdTTohNlRLc/akCPW0HPHTMecVjifeulQ/uTIVA7k6
         g0eJpjH0W6skRBts3ZVkgIcP2Q5ZDuG7Qovw3IrdE1aOsfpfww8mSEguCPseZO1BESsB
         uB4181+q+7QDXhbjnl3yrBSBGl9HFb+4WfT2NP5bdcm5conMfcpxC2VYVDN/qvrkBjTh
         D/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=USqYZkTz+gPkFo3EdrrUS721AawrRMxTCxHqTqY66wk=;
        b=ybCCc4xbUEitNNV0Zx2uqneBdlDW6EHMB73+7Y9GbUgcsscUk+PHzZzmQrn0jZsOEz
         j3dmoTLZNF8+9FYbYat6e3Edhk+R7/WMi44PTGI1ZTPwzJdTMkPC8Q6T7PkD2ugG/k/Y
         zBf+Fz6nVxuwLK6UkdzbnW94+3Bpa/uNNPcj1pFHp4y6G+hEixek4spTxo3yr/7ZlPRx
         sRLfhWZqcmt66TsROOnZEvNd93q9Zvg6GSkpwL7kIO3c8ZXWYBdo909cQ6geUSX7Vudu
         W/L6uOWXF5CJsO/cINBeTwR0TTNP7L65+zmiY27yawhyhJdI9HwArJzY1B+uixo9bThB
         Ps8Q==
X-Gm-Message-State: AOAM531aHL3vjGxFeqfW8y607jwIQTP0V1uZSuCh4qmxhHZ2Fp4Uf9k9
	A9H85S/IylnT7PAty24zzA==
X-Google-Smtp-Source: ABdhPJwaQVU9cZ2+akUUnyPk3HDyLGXkFebwCGDtP4/AiRvseG9M3s9Snmw/JgHne8IRurQclZO+Ng==
X-Received: by 2002:a05:6214:21e8:: with SMTP id p8mr1918168qvj.34.1642026943766;
        Wed, 12 Jan 2022 14:35:43 -0800 (PST)
Received: from [127.0.0.1] ([52.177.67.36])
        by smtp.gmail.com with ESMTPSA id v14sm880508qta.43.2022.01.12.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:35:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220112221523.1829397-22-kishen.maloor@intel.com>
References: <20220112221523.1829397-22-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Message-ID: <127c8b7e-c854-7ac9-6025-544096b2702b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jan 2022 22:35:43 +0000
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
org/project/mptcp/patch/20220112221523.1829397-22-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1689981079

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bce46a55a41c

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
