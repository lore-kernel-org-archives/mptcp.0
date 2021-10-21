Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E868
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 15:37:25 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id a25so2881618edx.8
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z0jVnGTsbNufUeqIbpu/6t7DIbxum9BM/U0NWKYPCmA=;
        b=Oz/7PsbQVvbI409bUiipQ4Xo38HrvcX0EQZyckugYxkR6UGv1dngKti1Saeo5s2tEk
         OtjWQsl0K9+pOD2sFr2ddOzqXgE8nsfY1aj/31LFBrobGnh16ub89tvQ0hXyTwKX14jD
         J1jzr2z4zX+FsRvGo1jMF8xPMX2c/hCugUVTqaTQLa4im+w74mL0ubn+LmujN/uDy1kH
         ZoAsxAsFHn6JrR0rGOexGKmpDnKILk0SJKgDbIgFbGvJSMqerBSDq9xdapnKxF7T/Ik6
         +cnRr0DMRL0odxWOT869VgzoPOWRfDw3WFR9acYoPgjxSpeITzautqnyojU62KkEL7gc
         pcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z0jVnGTsbNufUeqIbpu/6t7DIbxum9BM/U0NWKYPCmA=;
        b=ir+kTtTJ9suCs44ZE7bGaZq21IpDM0JSeXCjiLe5jLK44alZmoA0BxJCesyayH2SE7
         YV8za4YXvHinC3zKNbXau3jq5guDIsU2RMEysPeZz2J5brcL7K1tU5FC8crgVle0mbkF
         4oShcFn4AJrmhDcYIz126afHU/i83M6hrIrzXd1zQ5HbMlIjkjr3cbgF9t59xoaTUqyU
         g9QFbn8lyvVvttznHGtxOQI5kEqxWV63WVeu1Z0BCyrUgc6KxojXOdT2Ybp4/KG/LhR7
         0qouCDwuGeuFJx5jdI7Fm4p4i8AYwJEpbfloNkFW/VSqWQuLzCB8MRGavblDNrUxZEVv
         GXig==
X-Gm-Message-State: AOAM531lx7VEvTmKn+o5ICiessbg9tD0x9L04DO6+gb1B1xMclW2iAiG
	C5B9qAa2nu8xvfCOfeQ8CsKPF2gQBHQKYNgL4NA=
X-Google-Smtp-Source: ABdhPJz4pC7xG57Hin3hJilwRp3mINuxZo3CR/JuyYrY0h8swldzk95t/YOyIRL1QvUfnJ2Oxz04Pg==
X-Received: by 2002:a05:6402:5209:: with SMTP id s9mr8465213edd.250.1634830643761;
        Thu, 21 Oct 2021 08:37:23 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id p25sm3014547edt.23.2021.10.21.08.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:37:23 -0700 (PDT)
Message-ID: <d7f724d5-efa8-2284-65ed-8b0566d02f31@tessares.net>
Date: Thu, 21 Oct 2021 17:37:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-net] mptcp: fix corrupt receiver key in MPC + data +
 checksum
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, psonparo@redhat.com
References: <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide,

On 21/10/2021 16:51, Davide Caratti wrote:
> using packetdrill it's possible to observe that the receiver key contains
> random values when clients transmit MP_CAPABLE with data and checksum (as
> specified in RFC8684 §3.1). Fix the layout of mptcp_out_options, to avoid
> using the skb extension copy when writing the MP_CAPABLE sub-option.

The CI found an issue with it:

Reported-by: Tessares CI <no-reply@tessares.net>

Cheers,
Matt

(PS: this includes a test for patchew)
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
