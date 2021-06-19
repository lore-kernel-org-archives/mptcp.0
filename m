Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED071
	for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 07:03:33 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id d7so11627555edx.0
        for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8Qsv37e8XKgJtsV7XaODrvzFCOvC3+vHY2fY0sRj3Co=;
        b=BS6/kBaYMgbHxsiyC27d2XUJ31DV422SqEMBmfukK2L0NLaqVRvvtfSf3O8LG5D2cP
         8ikdks/BdTRFaWhkp+oaSZEl24cSnvDaF+vu7jRpQVEQgzIG5+Pa6TvM5JiCqF2wUXKb
         5pHXPPwqbdL3mf17cmLgTCPnQJP04Wv5+8aW4Quwf3lfteP6poYFiRSU/Ln5jbH+U0+Q
         F/GTkYekCkwPK2ZLf/8o7z+1lSoTxp+vUMgC87GvNAvzsaxjzJ8pNN45tuBs3h7+64tf
         O8ss97tcGwiqONOBO1Ruo1DK5AYwNHqUPqOkKv1Febs2ED8tCN2DRLQXnkQKb7QUPjcS
         9JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Qsv37e8XKgJtsV7XaODrvzFCOvC3+vHY2fY0sRj3Co=;
        b=mWJuzmDZ6KLJmQ69BlqQaW2fZ/SkadvTRX8o9ZKJB58NmDVN3hvLyK6fKSWLMAYdDq
         99iCMdy6MlvcwNeptCmo12oOzPQ9pIkK7gwVbPM5q3LxMEYrWFSLSIT6TyHnyFAF+pKi
         M+FTctc53AFbw0enZPLil38qtImdTkgW3B6QZyME/MaHgIyvbT/zKdGkfa3+lTWIdGLP
         TIQqx+/Ac2+fchrQ7SX04BmrM7nZ0TkgFjk2Bb1LB+vMcPnsDBjtMCLiHJaSBC1qzVTH
         95gAS3VcjWcMu3jmWmTk6cLu5Q5SiK8JBnyj889d6kVzO87YSQMnTv0jpVwwyp4BQJwZ
         ltGQ==
X-Gm-Message-State: AOAM532hd0dqjVrAW0pp2Ikr3QvnbzOjHtOcUYkBbRw+Y0wr/LqOiLjh
	hHWUuGdkYxbaM5+8/eceFtdeO34SjbiV7lin
X-Google-Smtp-Source: ABdhPJw8BtCO0yhNZYeGEAjeeolvhaBgZK2UU3/nv72r22ebRXFOg3WjPZDWAS499Ad5EtpACcHqrQ==
X-Received: by 2002:a05:6402:35cc:: with SMTP id z12mr9380010edc.45.1624086211756;
        Sat, 19 Jun 2021 00:03:31 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:6056:4c8a:a7ae:d72f])
        by smtp.gmail.com with ESMTPSA id u21sm1924871ejm.89.2021.06.19.00.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 00:03:31 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-net] mptcp: avoid race on msk state changes
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <a96e100aa429a9bb947a2b22cc16682649c93550.1623949487.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <097a9678-f576-00ed-9529-44167c86055c@tessares.net>
Date: Sat, 19 Jun 2021 09:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a96e100aa429a9bb947a2b22cc16682649c93550.1623949487.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 17/06/2021 19:05, Paolo Abeni wrote:
> The msk socket state is currently updated in a few spots without
> owning the msk socket lock itself.
> 
> Some of such operations are safe, as they happens before exposing
> the msk socket to user-space and can't race with other changes.
> 
> A couple of them, at connect time, can actually race with close()
> or shutdown(), leaving breaking the socket state machine.
> 
> This change addresses the issue moving such update under the msk
> socket lock with the usual:
> 
> <acquire spinlock>
> <check sk lock onwers>
> <ev defer to release_cb>
> 
> scheme.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/56
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP fallbac")

(I added a "k" at the end)

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree -- "fixes for net" -- with Mat's RvB tag:

- fa35d78a9419: mptcp: avoid race on msk state changes
- Results: 1aa8d1f89a86..43a335a6d44d

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210619T070308
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210619T070308

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
