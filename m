Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775ABA33
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 11:28:10 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-79a2216a2d1so1732560241.2
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790089; x=1693394889;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FZE2OnF5Ug7FV+nyzxNa3NRJw3/UM1VlSDGVzpSpJw=;
        b=Ebxi+5208BtMMWOwPcx+mU5AHNlu1xUIGFxCP1zCafL5tc5WvpVpML3ZrhMx0vJhU3
         KHkudqCBEZ1+AV9JGLEtD+EfQg/Ubab7/YpIHBNEtIb/HYmOfehF+WX0PGvMak4IWhvj
         GJPAK0NX5S0TlH1w9vFOWRTd6aJB+0BiSUMJXnHl3Q9Z9UUon6o6GOHPDJtwx4f4bzqR
         REDPYNg87F8w6wVu2FnccBw8EN5kPk+rII+5MGWS6UuKIJHjQiToigtCdAgUHxdx15oU
         CMJa3NPl0YtmGyupNHwY3EzRdEbctFpmXSSkFfWpLrglfJx4UnylPFGYvm5UYIghf/lo
         GU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790089; x=1693394889;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7FZE2OnF5Ug7FV+nyzxNa3NRJw3/UM1VlSDGVzpSpJw=;
        b=Pi5d4ZXz+MjGB1E9kZghlQvCnZlF6E7jtJvG83yganSLV3n1flZXWFoOTckd1sqsWz
         yejjCxvqJvhkMfNhDLVKWRd+WLwpEBrYCU9GDjbpvz9BZnqilhisl+/5w9pQIgWnWeAr
         xK07kwM4KPdoz0SxrxlVzHs7nihm+UJz88jTF6lmSBIjntN7Q26PHDj1/x0PPX1dzeqs
         5syK68XA7SzXAsotwPDkyugZdsxVTJ6IzFeI1ZOc0wgSNaAOntbNzG2HgLL/ZTBdYU3/
         LumWZ5Q+PhhFyabZEZ4DoPfv/KLSs7rhF9cgBPMp+2akWLwgKv/vatNJjzl2yw8zSRb4
         UdkQ==
X-Gm-Message-State: AOJu0YwOD+cqRv2jEq1c0i7kHF+TPa+yCJFTrwzjVa5eysRmqd5N8YHh
	3wKrrx8APXZOPBVg470Ehw==
X-Google-Smtp-Source: AGHT+IEbb27KTzmgQXz0cF16PG4pNpCPNnAdCBOuVGf++LYgQBpXi5n6Mp16ycJhFB5XkRMavHUoOw==
X-Received: by 2002:a67:db03:0:b0:44d:5298:5c00 with SMTP id z3-20020a67db03000000b0044d52985c00mr5424405vsj.7.1692790089355;
        Wed, 23 Aug 2023 04:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.45.224])
        by smtp.gmail.com with ESMTPSA id u16-20020a0cf1d0000000b00647432144cfsm4457568qvl.99.2023.08.23.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:28:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
References:
 <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
Subject: Re: mptcp: add bpf_burst set/get params: Build Failure
Message-ID: <e673baab-4b58-dffb-c255-5dbcb4604fe3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 11:28:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5950638723

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ac786dd759=
ba

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
