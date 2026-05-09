Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248313A3ED
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315093; cv=none; b=Kg8vEXzSNSya02yqbeoYETEKsIyvDMZ6H80yN04MDFayJNSDqd1gnmU8jRkPcj+xi5M1MY7TRjU4mt78nDL285lBNfBIOcGprLvAmXBAx1A+rTHo5H8VthxPa7rjMLkprJ1/Xe1UBONnlM9RDPdB+DyQrPd6ehaghF6va3At5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315093; c=relaxed/simple;
	bh=DZbP2xnL8NHT6qUFGSx3txLoCocMkfZe9HUKbGf4R4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=gSZJC8CX6rmdJi9a58+25t4v9IF+0EHhVnIiDsYqm9gHQb9ZgFZPG7ocUnqdZDOswu5clPaD2wCiFebT+O4vyU7uvtLa9bebQHEb92y9jg/hbpcVYNwD19Tpn01Wt9tCry0tWw/rjmSoP1frDmy6MLFjUc1BO8ycyQ48HaAOXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHbXKmtP; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHbXKmtP"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f30a4601bbso2983655eec.1
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778315091; x=1778919891; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaa+rL987TQBMk+TyFHgcjihb5Nocl1b3n39SwAn5Qw=;
        b=KHbXKmtPbN65BIcRLtCoIi/cXamQTzTwLYY7/NsCuqychjd5aO8z+Y/t9oZjy2RLun
         UphnJNHSH6TC2I+Le6fnCazh125s1u6t5JstwzXGqrriC5LIBsGiGxxHPSVQFZWINKoe
         9b4N3/BXJvjCftWrBuJ1TJUJzen2W73lf6clw2d0/Nhr6sCyabN1zjLps+A5eSy/T+A5
         zT27K+WwhYvA6hHElmAHfYFxxtLUV3z/CNRxhI33AHTce/wBe1HSHiDjSAiVCVqYpyaI
         yzXdoL0Gh/xqHz3eaIvHT4bvWpm2F5CnB9t0IJUwh1g/kFlvOP12naHmwbn4ft/DgAYI
         qPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778315091; x=1778919891;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaa+rL987TQBMk+TyFHgcjihb5Nocl1b3n39SwAn5Qw=;
        b=Aocu56rreuG4tul5btK2E49bKlgfUoG7CxJNx+KP6SZX+oJH7nsusPW2dk8C47ar2C
         eWbSOHcapTsMoOpD6wperelSllFutddDofcSSG4Gxmn/JEFwZQlSF/9xnEIIXXMg1yW3
         UXGzIZtK11XbnlwweXKFV+7/IK3FuJNCfW8U519QL1KUUu33BAuCnpMyCyeAdS/n2MQ6
         nE/pu+hl0pWaki77skpVKyna0qkclCs+C2FnNs+D8oEkUbylUK/cSe+sj7jgGDoIaDbj
         RvZMP2+T+h5tfXWm4ZLW6XXht6o/cZhjRVVAJlav+TGzfWnTy9+Krx/NPRKNBN0odCwh
         CfdA==
X-Gm-Message-State: AOJu0Yy8YR7HLFpo16nqNjv+qAvnNqhkSwM3RiJQOU6xBYEwEw8wGoej
	1ij9DM+4bndvVQerErMSjhB2HUtE1p48LveFgBGL5fZ/MZxGXQPqopK1Jgvs
X-Gm-Gg: Acq92OHXxU3Yj8ZA0XGw251DbyTQFORiLMNbdghoUynKrxjFs72nxU2tHzKJkEyr3NX
	5bAtrd7tbhtktyM3GnVtGng5Zz1PfNSbHhYD1L7KFIhDqmUvXIlgTMyBv5IOU8hVVfHwEmMWGbK
	JpQ2cxqA2UjgTe5zphY6bvXVQ88UNfDFKeGIh98hURQSMZ6Lg1kCLC+0iKe1+2lw9YSeNtYPqd3
	JkFPAFHMwIV+0IMe6uJNaFaytzJXfgQq3o4n2e1Vace8NTlq+N7AqKzt8YpSvrxYXdr+G50Be1q
	KjXwVE7xdXGjZRVYEkM+gLxEjB8ZLeMzh/giEi2/vJCfBx06/72mHdaDL+N6MCfJDH+MnNn5DCf
	+GVBRQtZuF+hjiln52xoBAtANEiizwgcOBo35AcemTIScEDiockWOXPYY+dDTqlrpY3CfzuO3Tg
	DfFMq0FkxhwAmMB++gwkNUrnzjZGukrKyj/y4=
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-2f54c587faemr8021561eec.15.1778315090786;
        Sat, 09 May 2026 01:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.6.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm7316038eec.31.2026.05.09.01.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:24:50 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 00/12] mptcp: address stall under memory
 pressure
Message-ID: <ac3ea663-4e0d-1175-db39-3eb408c89a8a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:24:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/25596100153

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ea=
90bda1176b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091952

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
