Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1F28E2
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 11:32:13 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94ef0a8546fso216320966b.1
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682076731; x=1684668731;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjpV0glVC1qz8hLY+Y5AmfPOZTYmHC6QV1zpMuNkw4U=;
        b=vBbrnXv0G2UuAZzmT7ZqkmNKQDutDR/ChXe8RSPO5j/Cm5yvhwoADo3xcSv3zDs9fK
         KptHUFuQcp025+d3GquwPePQWcF+nP37G1/iyHu/hfSVQ2FfBDOb24MmoIKrVfR+LEIe
         IvTGrbELuyWS+5Ynu4fXk0W+0bA6xr7LxQY6tkDSXMMDUm/+5xTpFLh16qdm8RgVMMpf
         0c1Qo0TAA9G2FtXoO1e2R2+bkqPb7MbBkV0t418zLQwrttCBSFN2715geqk7PH82riHL
         xEAaORv/YNsmyrtGpTI68kZPUsxkJX3MWXj4Yd4WGYcx9GMmFomNb91v9mTJMuvEQiLP
         XeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682076731; x=1684668731;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjpV0glVC1qz8hLY+Y5AmfPOZTYmHC6QV1zpMuNkw4U=;
        b=KGWqBXG800apP7A/5PdkHbD5H3aGwZhUEmCmwLsUt8Dhuo9cMFCQ9obhUveRrVjWZl
         4YAM7DLcgVx9dANw0eii6gnH27Uer9yQc5lS+MhDdnSopvY/e8jN7gLcdSGRN7VLItak
         1sCWDX+DLZpYAsGVLZMnJ6naOkq3WQWiZHmvzprpJRKhCKj27M0HEgCoCMe5ulinYCiX
         0ofEPvHE4R2jrYWHiEkKdV5T7rzCJdKvVOTUFHw5ywRVie9TU7mS32LNwoClgk4OzL4q
         jo6LaEPLuED/8UGxQWCBUcKYmYEH1Ci8tmHBSoxUHhwPKoiIlnrRucCtbpN9ZpRVThBz
         ubkg==
X-Gm-Message-State: AAQBX9eRnPbvsGkIY4jSWKeMIhQKSOj3l5Bc0fr5k/dHoR0nQOMcRWyU
	mEMIqtW1AOR10ojbCOLrQRSjE6NTB9UwJBtiyew2cEie
X-Google-Smtp-Source: AKy350aqAOgoBJ+LHzaD76b14yW5Nd9AhpD4gKChl5svRXEn4P6WelQCmfet6c/dXJkuMPZPmiVlSw==
X-Received: by 2002:a17:906:a10a:b0:94f:695e:b0c9 with SMTP id t10-20020a170906a10a00b0094f695eb0c9mr2115265ejy.5.1682076731338;
        Fri, 21 Apr 2023 04:32:11 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b0094f3c281b34sm1909650ejb.196.2023.04.21.04.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 04:32:10 -0700 (PDT)
Message-ID: <71b42aeb-e405-d65b-6028-ce7ab0e55134@tessares.net>
Date: Fri, 21 Apr 2023 13:32:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 mptcp-next 0/3] mptcp: add more mibs
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1681481877.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1681481877.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/04/2023 16:19, Paolo Abeni wrote:
> dumb cover letter for CI's sake.
> 
> Slould be applied only after the current tree has been crunched
> by syzkaller for a little bit, as this will likely change quite
> a bit the timings of some critical path, possibly hiding old races
> and make more easy to reach other ones
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/378

Thank you for having looked at that!

I have a small request in patch 2/3 (and a question in 1/3 but that's a
detail) if you don't mind.

We can also apply the patches and do the suggested improvement after if
you prefer.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
