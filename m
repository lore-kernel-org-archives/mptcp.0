Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE312C9E
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:45:00 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id d21so459037qkl.3
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 14:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=4CUnoAu/WET8TuNzusZu5nyDNG6phQxszSI2vpNdqGY=;
        b=RLewJcQv48rYmqUEjjvlr65QsO9PKgHQPqj+9Z4FKNi1wNjgUO8y/5DEDTHYZzB2LW
         fU/64vzAnTmG9Nfg9nqXNOzeG8125OakCVMfCaBaKklfT3vET38MgaFtnphXkfcQ9PNo
         lZZXhs+r/OtFhBsPKNxC1KQVuatgo6T62CPNrmUS/2FDkakLUuCCceA27YcrJ+ySpz2G
         h88ULq4QXoJcnzSzIDD7/N0/J0vN5NdT0N2Q0D+7Yz7FXx7PTcZSUZ5kVotyxWdE47bw
         7xcw0l0YU/Q4RJ/tz/hcvrA+XsT81u/d/h3kNpcuysSOHA4TOPnn2T87Zti02K+Zs4YM
         PU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=4CUnoAu/WET8TuNzusZu5nyDNG6phQxszSI2vpNdqGY=;
        b=24hmViCgkS+KswRdr9IhAb8vrLoGsXBD324J5Qpu1WTbLqmMFa7Fg+ESb5+tcl7Xqs
         u2m171NaDyD9ltMpw24jddirdBNywUnN/14UGmSjDSMd8lmxCAGrlJBHLvd9s+pg+Ha+
         jj8hjBdNpvFv6R/OIIvkkdIQ2nwt4lHuaKIc2g46tVL6RbhBGjs0xUNlZQoiqkNnwZwV
         pyfd3EaIda5G3KIZ28vtRzq/TIRDlUulpJ6IK2zgklUVEsh4uJY/KFFqunb3EIsUWFHL
         Ed5rgu9er+Ns5T2hAFvZu/NkB/aLQ+a6eONWZW7GXft38ZyAlop3WqvjW9NVFwx3UADC
         tSeQ==
X-Gm-Message-State: AOAM531rJtTbWGGQGY6Zy2Xf4Q4G1pAFDWUsZJhsJjVcx8eKqzl1AkY/
	krM2Cy9drR50f95b8J4/ZNw0uZFqUg==
X-Google-Smtp-Source: ABdhPJxGx9prCLE44gIY+u5Ncxn+20zKcVtTdHV6Zmfc8RWS2+w1Lk7gazO5pvkuDuFjrm1ZaJPg3Q==
X-Received: by 2002:a37:61c2:: with SMTP id v185mr139380qkb.719.1639694699198;
        Thu, 16 Dec 2021 14:44:59 -0800 (PST)
Received: from [127.0.0.1] ([20.122.162.103])
        by smtp.gmail.com with ESMTPSA id j126sm3602137qke.103.2021.12.16.14.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 14:44:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20211216222314.1244708-22-kishen.maloor@intel.com>
References: <20211216222314.1244708-22-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Message-ID: <034d8dfd-b3e0-41a8-4e0b-b6758a5544e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Dec 2021 22:44:58 +0000
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
org/project/mptcp/patch/20211216222314.1244708-22-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1589719791

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dbbf44c8bcca

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
