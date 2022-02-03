Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD82F24
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:26:38 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id t199so2035386oie.10
        for <mptcp@lists.linux.dev>; Wed, 02 Feb 2022 19:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ntJZ/NHWQTGsLUYfip7XnRIyALcJ2T59pZq7YOMr0yE=;
        b=fGAZ4AhuW6uNZYkGwHYTX3Khw8Hwjgb+9iLeYNoQYMXkW7cDwdaYjjeGb5TCEs7+G0
         OwXurTfVNs+/TMTjb9+jmFiIQKoZmOrPos+IzMzKwT3dmLnOi/X0NzbnGt5YCWxBAF5Z
         hZHTt/ankuEmqPIskJMG/VitEdMk+Lw5eSBHo1/0Y6bHQx5rcyqgHO+eI7xPX//amZMD
         6+B2vG+quTzENr96Yhv0093gqBN2BmGBLLlWT7v9JAHJ/S9dfwebTLNVY7Ak8lDztfBH
         8QRhTUhv8felq24zMwCyww7BDSiBJ0jSobyNypP2CXwpNP2U98Z34vMcfQX9VDalM7yP
         SEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ntJZ/NHWQTGsLUYfip7XnRIyALcJ2T59pZq7YOMr0yE=;
        b=0YEqC7tsTOVAI58a/1iJ2tFuSzXSTT9Ct1tCEgjpbVss1fHo58Hf1KTx5bnafs7rHS
         1uhvjXiyezHnJev1z9rdJw4AVtI3MdDF6Zav54UkzWoKjNrkqn/1uBRW5avnOl43LPeb
         YsxJiWx7MXpS9G6LyBWvKIWquyhXhP389Ii7k/FBhEoVpMQpUrzjbMXJ20sHaK9wAZ+A
         p2wx7Pl98r4pIaIzBNAai+yxJ3QkRowiU+wVMzPA5tu02T5KSgqvHlPaVHWU0OvZmAOA
         IX+PGyUJCWOhknXia8bg4smQRzricpNcptahjw92CtnSfOyxEcEcvT80JDmlbo0XI0YR
         ji+Q==
X-Gm-Message-State: AOAM53176wn2/VViuEAkDqN6u1Z+HJdFq/gM+uOcm4bK5Q8LY14KsfHn
	EAHE2KQub5AIZtnhh3BYtQ==
X-Google-Smtp-Source: ABdhPJwmWsX9t9aTlmfaVz7LdLyPdxweubLJmuOaTT3nGtXf0LEtpGFOiCK0nGI1ubPK3jW66zfBxQ==
X-Received: by 2002:a05:6808:1907:: with SMTP id bf7mr6842497oib.262.1643858797987;
        Wed, 02 Feb 2022 19:26:37 -0800 (PST)
Received: from [127.0.0.1] ([23.102.181.180])
        by smtp.gmail.com with ESMTPSA id k17sm19216969otk.80.2022.02.02.19.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 19:26:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220203031331.2996457-9-kishen.maloor@intel.com>
References: <20220203031331.2996457-9-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Build Failure
Message-ID: <8a6a3bee-66b9-ee0d-b2da-aec091c4ac5d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Feb 2022 03:26:37 +0000
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
org/project/mptcp/patch/20220203031331.2996457-9-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1787467514

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a581d3db61d8

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
