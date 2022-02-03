Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E032F21
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:38:57 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id o10so1478656ilh.0
        for <mptcp@lists.linux.dev>; Wed, 02 Feb 2022 23:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=18f9zG9zUWgcKlxtKWaUF7Noy091gN0vsAf/Ld0u1EM=;
        b=Q0GJqpRX2NBCVXJdJy57SW6CQPLiicKmhUj0yAO2HCmXOadMF0m2m76QEkP/k1AmvV
         1JI989DDmnppujU5UN18BTonCVd7l2SfyJLDjdM2z1+11djBcCA8tObz33wrQ2m4KKFb
         YYToii9Oc7tWpr4VNapkfMyUQ6cPyHcSQNCH0Yph8UVQTTsqvG5eZPCH/8+OMfSH69os
         jWkqRg416DTIw6yZH/8qXbsoPckfMWgee83kA2G7rn/8hRVu6uWC65sByKzQ4fThqMhb
         EEfEBGAs6PVFOWxAhY3U7HZkbMOFgKzMGs5cfKFIFebIdxtylnC1WBeMR3aKRn2Oce4v
         NMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=18f9zG9zUWgcKlxtKWaUF7Noy091gN0vsAf/Ld0u1EM=;
        b=2Fv5egdF4gZxSMfqwNVpUOPQkaKmb7WcRIXwkF/8Qqu2Di9AfvWFwy6kvKysMZ+8ag
         BwtGYmPiy8G7A+1/MPLkxF6SfK6PsdvvYes1mQLd2PiRe+78HnYNxlA76s3ZFE3UILUX
         Tt+h1xFnCpUzaj6z6DGMYU7BAENvBzXpAX7vLwFDiVBwdnagm3Zj6hnfuqGV7AZcGy+T
         wByP0Zn1PFsIrjuvEGauwMZ69WOtafHmUbtYVOsQAKJOoE2kbWrciW9ZuxXtN40D+73v
         AZup34nEazJcwZ5BP+vsxjmsFEpVJJXwv2kSCIpJxCnPjvNerycBgORJm3oQT9Nk/+w6
         93kA==
X-Gm-Message-State: AOAM533wSzWjg+06DpcSPiR4+nUrkk7gxMVpeQeCBcF7sXcoiT3lWqDg
	9twewUUIUyE+h9m+2WijdA==
X-Google-Smtp-Source: ABdhPJyLiJOcbM0/CMKJmFy+l7eXgXcgbRZ8lcSptp60042BQYCYt9lwmA/yicIwU7az8yW93++sqQ==
X-Received: by 2002:a05:6e02:1caa:: with SMTP id x10mr19092734ill.249.1643873936900;
        Wed, 02 Feb 2022 23:38:56 -0800 (PST)
Received: from [127.0.0.1] ([52.173.246.88])
        by smtp.gmail.com with ESMTPSA id t15sm3658056ioj.24.2022.02.02.23.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 23:38:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220203072508.3072309-9-kishen.maloor@intel.com>
References: <20220203072508.3072309-9-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Build Failure
Message-ID: <fa0717dd-a642-c2ef-b8c4-e60b04412ba5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Feb 2022 07:38:56 +0000
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
org/project/mptcp/patch/20220203072508.3072309-9-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1788178430

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/23ad466ddec7

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
