Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398952FB3
	for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 17:31:57 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id q3so23518564edt.5
        for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GJ2li7R6JVMooj8tXeeRTO0kNb5rucJVNhEjl8ccqMY=;
        b=xciQRStKwQzenG1BkwMZxIoPOVFtBRcR3qzosBahO+hwlxY8M/GG62EUEExj2o3XH4
         hfaVmmNPwn76t1bFerAPWk7nf7MHuSbH6JWM/zyOtaMH3n7QAbEF+UxOlKqUiR/2nWGy
         1s4qyKSPC/ssQQNYvIDDbMxkp60Jg2+jDTRkDP5Q1NrM9b84U9NLRUciF/mDTTpLaHW4
         oXr5zhht2jBnKkQ4sywxpuq4yW7e3GDdEkNPbjiJeMSQF5LNInOSy1ygm/j6TCULy78y
         VAhqIcd5BT4tyr+CN4GD4BSLVN7ciuBM3PZ8SSPQbfGPdVwoRlsrY4EcEKjPcMQdDwlN
         KFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GJ2li7R6JVMooj8tXeeRTO0kNb5rucJVNhEjl8ccqMY=;
        b=Oh2v9u/+oMGgh1VIXsNuARb/LALMMt2oYRzs1tC6sdW9pMMLz/oIzhdGiLQUn3kn5a
         FN/W01ZpJ/9cCz0gkp/0YWxawpE1GwXJ70YtSBjaHlReq/hJfuti6Li4F3yCMoD2+fCZ
         OuaCSLN0bfGn9iEyKGMMAF971R0zUzWWLK4PlfzxwVMV09ID+jQA/1j2dKKRKIw9HQ/h
         X2yXie5SsVs0kOEvLXStYDiiSutv6m5t8AIMxKI2hv1tLqeVanfyB2Kgjl5ux7i5ui92
         USwMDWQ7MMmXqNbYPRJbiJHcQB880QgTghvDGclKvrHFVnlMbNDManwOf9AvqSbBYPYT
         YEFw==
X-Gm-Message-State: AOAM530YbSCKbfpcyALeEadN0R1amztM9C8Bb4Nie48apAiMt/eIqeEk
	Ag3KgvdbrAr63c7JxbLEYn8y3wTYJfvFLcDR0UE=
X-Google-Smtp-Source: ABdhPJwZQxaVVnIdAxiiWUt+0vINqYg3TX8nTz9b+nkEqBB+Xl8UFdL4gmqtmhXeRgjQTsGNC9tnxw==
X-Received: by 2002:a50:9fa3:: with SMTP id c32mr22033746edf.354.1629135115422;
        Mon, 16 Aug 2021 10:31:55 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id u16sm3472019ejy.14.2021.08.16.10.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 10:31:55 -0700 (PDT)
Subject: Re: [PATCH mptcp-net v2] mptcp: fix memory leak on address flush
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <b73d65b78787ba0ecc36ec2d5d6fc2a68415d938.1628863533.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <96a46335-40c7-ddbf-be45-aab07b8d3d4b@tessares.net>
Date: Mon, 16 Aug 2021 19:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b73d65b78787ba0ecc36ec2d5d6fc2a68415d938.1628863533.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 13/08/2021 16:05, Paolo Abeni wrote:
> The endpoint cleanup path is prone to a memory leak, as reported
> by syzkaller:

Thank you for this patch and the review!

Now in our tree (net) with Mat's tag:

- bbffcd9faae3: mptcp: fix memory leak on address flush
- Results: a5b32fb5c3ca..55f3937bfef4

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210816T173103
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210816T173103

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
