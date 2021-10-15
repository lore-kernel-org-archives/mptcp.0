Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A172
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 10:34:00 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id n12so5420008qvk.3
        for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=JvZoR2e0DNYWMC+VzRJfjRS5HndrqLc1ylsdd2n2SCU=;
        b=HebYYVsB7yJAqrok0Ojdu6Z0C63OR0ubbbWwkD+fPrBl721HXcFPLSMveS7T5tK8g9
         3ihnhJIMvbEOQt8mCFRVaC3pEe7YsNfMCTcxEgDE4PedOInPjt7NMocY4ky+eYvET+K3
         1ua7PWOVVhwZ+GGhYO22KlakR3uiKhD2bRTbXBobfeGFy5za11rsN1wro5WGL1I0ckCV
         ohASDXe0PdM2j//nbLkM0fdxFKtogHmVdAOR8hH0iNwWMVR+i+5pnYVjmjmFsK4O1ctf
         HlsvYyIzvxitFL/CCFq0H3gd/moQiYF4Tt2Sq8XgVnDVCciBq+onfqfHayTlnz62fRnb
         f6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=JvZoR2e0DNYWMC+VzRJfjRS5HndrqLc1ylsdd2n2SCU=;
        b=q1ODQWFDWdsbDTFCfrwxyY7Neeyd4XUptbBbSfdv+TGhWv+lK3LMTLveHD7t7yqvez
         W0p07yeb72MbYPaK/lSmzerg3gz03pV9/HxHXgqp40RnjbMDO7e2lbXy0fU+3mkJPlO2
         +17vaptTRw9NeTkH2g+U9oWLArc/d0433eMDUsNABwwzNuKQPaDQgYB2I/MDVfUDPuhz
         g91UcAva6q4WT/gD/byqxiiclZzDB74smHDCOPNB4PR/1l6Tk+tKn0GfFik4Kk+NttdC
         8o0yrTeGu5sL6Yu37D7hEUD+FKcUh02F29F7wQb/20aALX7CwOONC4Srk10WyarxQuBp
         5+Mw==
X-Gm-Message-State: AOAM530WvxiTouSKAx/3RDLtUmVhSr0DBKGiLeJU1gpsfEYlwl6XgO76
	9ErJWn0JmRNYBtVXL42KEQ==
X-Google-Smtp-Source: ABdhPJyUCtLhvpZSqQDAQtF7TTQvfhUMhfp7K+62ufZePPTEWozBNv1rweukXpQnR9TQHAuxiXP8pw==
X-Received: by 2002:a05:6214:628:: with SMTP id a8mr10504565qvx.21.1634294039996;
        Fri, 15 Oct 2021 03:33:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.201.110])
        by smtp.gmail.com with ESMTPSA id bl37sm1023351qkb.39.2021.10.15.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 03:33:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7c175c9533f66651a3641830683ce804f3915c3b.1634289695.git.pabeni@redhat.com>
References:
 <7c175c9533f66651a3641830683ce804f3915c3b.1634289695.git.pabeni@redhat.com>
Subject: Re: mptcp: allocate fwd memory separatelly on the rx and tx path:
 Tests Results
Message-ID: <9cf95d14-a9c2-5b2d-38c2-81be46228e30@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Oct 2021 10:33:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6752128921239552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6752128921239552/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4506926177320960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4506926177320960/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/

Please note that some efforts might still be needed to =
stabilise the tests
suite when ran on a public CI like here. It is then =
possible some reported
issues are not due to your modifications. Do not =
hesitate to help us
improving that ;-)

Cheers,
MPTCP GH Action bot
