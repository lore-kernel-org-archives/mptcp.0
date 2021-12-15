Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E332CB3
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 15:59:51 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id o20so76882902eds.10
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=AJrb5Z6zV9Mx2IwJMTsgucqAcefc3N0lCxlBa5pHkCw=;
        b=rTph1tzEONLq9ddvW/OYjbXjIidwp8blIqMek3D42YdvQUOXv+KGlqZE+hzT4f2pBs
         UP66sEMuQPHeJbk3omHbOCBXd4BDfOty4uO9DIBH6BvnvMRMqx3uEexJmWCEJ88fkilM
         UXhp0L7E/KfVeK60qSvIyZ6qP6PfpYfXmW410QRs1k50O3GT6foFjzg3Gx5sQeY6ondW
         idCHm63tVRYodsWorzE3lEUXJicmNBDYsrH69uQiAI7xZln6D3dxKbQXJWKC1KFyeGeH
         g+VUaY1iHTE080Zcs6B+m8oh5SNlPL48A9ezXUzDr+XxUjfHVBybzL1sbfFgul3FPtvd
         zrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=AJrb5Z6zV9Mx2IwJMTsgucqAcefc3N0lCxlBa5pHkCw=;
        b=20VtLCn5bemrwYEklec8G9zmJavZarl88GF6IJytMzSQPWeUyS2GcH0vXOo2VYpEAV
         W/K8yfWWs98jbvarqc1+QMJCPEpenzUonp1xzIiSELQhJPojH8e5D9khqf7PDCkuuNtn
         C8VEfF65Ok44GXJpE+GLUoiNAUPJEuWUL3mHB9/g0itcAhyP4tX2Y5BJYk178Q4VN274
         GT62Yk3NaiESxoccg/Kwr3WF0Dupr71dJducNHBDBybkAFznt3+vrd1lwP18CRcL32fB
         Yg2c+h4NvZWqD5+BVOrZ3U/U+f5IatbE1XNNWTaelhRhs/tWghqhugDF0Mxsk09T6etd
         8abw==
X-Gm-Message-State: AOAM5310PY/+bo6v+GuLXw9o3BoGv/SDkUvlfUXzy15EiLsg75wX5gd0
	V7frrIdfig3VdtC53WxxlmWEuyfdcAVcnw==
X-Google-Smtp-Source: ABdhPJxXdazsU9nk5oo3vuNuGmb5ATYlbnMFhyPmFvTipHxQ8PELpIhFbbH5/5gmh5DDWLoZzvPaXQ==
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr15523353edb.225.1639583971950;
        Wed, 15 Dec 2021 07:59:31 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id mr38sm385896ejc.109.2021.12.15.07.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:59:31 -0800 (PST)
Message-ID: <a2aa8c2a-5c78-f443-88c7-9500e1d85944@tessares.net>
Date: Wed, 15 Dec 2021 16:59:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 mptcp-next 7/7] mptcp: avoid atomic bit manipulation
 when possible
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1639500873.git.pabeni@redhat.com>
 <c813c051e41153bbea3c7881acf81bb175e06fd6.1639500873.git.pabeni@redhat.com>
 <e18d05b18db309488061f64af8619c3cdcb37534.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e18d05b18db309488061f64af8619c3cdcb37534.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 15/12/2021 16:10, Paolo Abeni wrote:
> On Tue, 2021-12-14 at 17:58 +0100, Paolo Abeni wrote:
>> Currently the msk->flags bitmask carries both state for the
>> mptcp_release_cb() - mostly touched under the mptcp data lock
>> - and others state info touched even outside such lock scope.
>>
>> As a consequence, msk->flags is always manipulated with
>> atomic operations.
>>
>> This change splits such bitmask in two separate fields, so
>> that we use plain bit oper operations when touching the
>> cb-related info.
>>
>> The MPTCP_PUSH_PENDING bit needs additional care, as it is the
>> only CB related field currently accessed either under the mptcp
>> data lock or the mptcp socket lock.
>> Let's add another mask just for such bit's sake.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> This patch has still a few issues - basically it lacks a bunch of
> BIT(). @Matt: could you please apply patches 1-6 (with modification on
> patch 5) and leave this alone? I'll try to send a new version soon.

Thank you for the patches, the reviews and the notes.

These patches except the last one 7/7/ have just been applied in our
tree (features for net-next) with Mat's RvB tags, without a few spelling
typo spot by "checkpatch --codespell" and a typo spot by Mat in patch 5/7

- 7dff646b6956: mptcp: fix per socket endpoint accounting
- b3b313667f76: mptcp: clean-up MPJ option writing
- 93ddc71f0055: mptcp: keep track of local endpoint still available for
each msk
  - I had a small conflict and while at it, I added MPTCP_PM_ prefix to
MAX_ADDR_ID: https://paste.opendev.org/show/811700/
- b3adca806c71: mptcp: do not block subflows creation on errors
- 0f4945b51e44: selftests: mptcp: add tests for subflow creation failure
  - 07368dde952a: selftests: mptcp: apply Mat's comment
- 1d0e64a63ddc: mptcp: cleanup MPJ subflow list handling
- Results: 8c25dcd7cdf7..c94ca039d4f9

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211215T155626

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
