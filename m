Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F42C82
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 16:47:14 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id o20so717863eds.10
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=9eKx7ivAuz37C3V++mkTxZCsSYh+eWRb7wuHFlQ1kIc=;
        b=7P88jPNiQTpsTJR0GP/ZaRcuO1QBK0eXUOZ+k3BwOTHdg7bCc8vE3QEywL4sZxhT4K
         JuoVS7xD1ISqQ5Tww9kaEf0uB+Uc60Q9viu+DfQD20CK0//u2Qu0DHG0R+0uaMwJK2yN
         uomi7yystCiiB2P0BRuzuybJAj8lryam/E0tcHme2VKG6MN+mQ0+twpZnwM9E6yj9KDR
         y/IIkO0aJgdJezjM5yBiKbLJMa+fdT2bqS6XY0Jr2nPfrHHcA40g2kBf67wdPa618G3h
         QtjnKJ/g+qaCQz9+F9ZSiMYHp19yJ+vGD4jRFP1uIzaJ2dg/6tu7Rb0swW76c+AaSzZZ
         B7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=9eKx7ivAuz37C3V++mkTxZCsSYh+eWRb7wuHFlQ1kIc=;
        b=r2N7VS7BSy1/cBrWD8vEGizQ91Nzv05eY/fFZjCS9fSjD5n0QyWiJZgh4Qo3/d1cYl
         u1gvX4v/uIAYkywmmH9t3q1TCAKX3KIrowWQMkJeUq+QNGId/msdNTFOZf/NMDhJXeu2
         EfHwZatX3IslRilhgEUx80RWoyocQn+HGXqOAIed58A0LVJJYNZTjDu+Gqy6d44XAx+I
         dln+XVsr78H6pCRhxWzx4A9aqGjFRw85Aj4BNOSd39bfgfLekeE7+fLxKKn5f5gUno7u
         0hkuLmkQ4dOQmTE9LvkmJDF2OREVTL1AmYFqyH/ES7xxOgTO784hnYmaI6kMNF7nx3lJ
         dIyQ==
X-Gm-Message-State: AOAM531GGO58vEE313qAhKqnKKB3NDaAaSZc2qdy7sDs1+mD7q94W7Je
	z/5jYfPZSJ/bvWSj1Hn0l3vxVQ==
X-Google-Smtp-Source: ABdhPJza8cDLc9kGAQXnm4QR8d8IG3vXfU0Nm6gTvSkjfixj5bK6s7BmDoNKXQcJeDZx8hv9cqyaLw==
X-Received: by 2002:a17:906:af1a:: with SMTP id lx26mr9694507ejb.44.1637340432760;
        Fri, 19 Nov 2021 08:47:12 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id gn16sm164694ejc.67.2021.11.19.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:47:12 -0800 (PST)
Message-ID: <c84024e6-9a4e-9e5c-6f9f-e4c750f9aaf6@tessares.net>
Date: Fri, 19 Nov 2021 17:47:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 mptcp-next 0/7] mptcp: improve accept() and
 disconnect()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 11/11/2021 17:21, Paolo Abeni wrote:
> As outlined in the public mtg, mptcp_accept() is currently quite
> suboptimal, both from performance and code complexity
> 
> This series tries to clean it up, enforcing a wider lifetime for
> the initial subflow, so that we don't need to acquire additional
> references there.
> 
> To reach such goal we need to properly define the disconnect()
> behavior, which is currently quite incomplete. Additionally allow
> user-space to really disconnect established connections.
> 
> Disconnect() needs in turn an egress FASTCLOSE implementation,
> added here according to option R (reset - the simpler form).
> 
> Finally, the self-tests need as pre-req Florian's patches implementing
> SIOCOUTQ

Thank you for the patches and reviews!

Now that Florian's patches are in our tree, we can apply this series
too. Patches are now in our tree with Mat's RvB tags and without some
warnings reported by checkpatch in selftests (except the ones not to
split strings to different lines, so just some small things):

- be5470135e9c: mptcp: keep snd_una updated for fallback socket
- 3dd1385ee6a2: mptcp: never allow the PM to close a listener subflow
- b382fb5fa27c: mptcp: implement fastclose xmit path
- 445bf9531ef7: mptcp: full disconnect implementation
- a2fcf84f7b73: mptcp: cleanup accept and poll
- c999f3f089c7: mptcp: implement support for user-space disconnect
- 707b9bbf2820: mptcp: add disconnect selftests
- Results: 3ebf8b8d1426..736c6532dd92

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211119T164652
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
