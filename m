Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67A39CD13
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947298; cv=none; b=rhyyeRxf0Lo0wXsC/AY6tj+5EYbVrUgUkZvL4ziiCjQCbwfhtRAIbkdy9JbdXCpfiBJMjhDzrfkrYOdb67a+Vgf43pDZHRZOV8S93YGP2YaCsn21Mxhl1iLkwZ/tBzqJZ1+zp4BxZzix9kasiJmRWWJsWnYcvLMO+UZaYGO6oWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947298; c=relaxed/simple;
	bh=cHysO5AyRFhVYcEymhpMDhW9PRDdYMYzViNhf9WLVVE=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=PxvnsyAfilFa/UWubNdly4SeRk6bUdSF/31wZCnxUOrnix3SKrMxu2V119NSqxQl9NX9GQAIYeFNPkS2xnVGgVz3R4Khs+5Yc/DgqAZm8rrlIFYVnxmCmth+itWU3/aSlYf6SyUj1CJhwGeQIMgny8Eg4CL4uudn45xK35++TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG3A0on2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG3A0on2"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1874394a12.1
        for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786947296; x=1787552096; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :message-id:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHysO5AyRFhVYcEymhpMDhW9PRDdYMYzViNhf9WLVVE=;
        b=ZG3A0on2zfhW8uXojB+UIBD4AZfaV00agkub48E2EvcQzAHFuJAgNM7zgk9UJKRBlA
         dM7ewKr768NzdFS8REAo3fpwij4DfrttEcf5zqvVS9ySyA8z+ILtoasKYN1/WW/Z2bdG
         +N5GcFtIMdEGBtIRrH8lnb2bZ/+PmAd2tnnaT4Xu0PJht6LMAX7Pu+eGYG+JResLoVdD
         hQ28F1Bgnc5RBHJFWTYGKw4X33s+pG54XneVqOAfw6cj9S3QLHSNiIU07m5J/2NcF9QV
         hBxipLERiM3gmy98X5Wa0RGn3yCFJScuZY1nYzQUhlQsiqVrJxatu0PpOdUQNJRs1Xs2
         dUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786947296; x=1787552096;
        h=content-transfer-encoding:content-type:mime-version:subject
         :message-id:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cHysO5AyRFhVYcEymhpMDhW9PRDdYMYzViNhf9WLVVE=;
        b=WW4h0O9ir6fXRfGTKSlGIv6QnDHbNUpiuF361OT0rpMAI5n0hPikHSKV80aRo/+3zx
         LD+qaBNXkjAYxML4q2HlI5inHdB74iUITZ3iciRcqZWFMYukDVZjREa5a2PFKgBi3SeN
         25dB6pRjQL71fD6P98H+Bu+1uFKQYDyYrPvAtBnkfgNtSvZVAnqQFkFq8w3H+tyxWmxO
         467G23rOTQ29/lli1lSkNV45bpEJ604oNHpYYscUfPQAM0fLubVr3PwJtj6OxPXd2kcB
         JFOzV47Mic3U/WBA3Hlz1vnma4GvhBPeNOofq+8HSTV7d5k/Puj6OoPKQNVfQQBp99NM
         IL3w==
X-Gm-Message-State: AOJu0YywF7oZc6XjIvauqnT1DB2tqgH5N503VeZzTnM8wJOuojXKajBi
	JQJQY+ptsFdkRlSl99HwrP9JmTF9fOs1+NyFlrHAgSck/HWSIgwHdfw6qhc0OGp/ztg/
X-Gm-Gg: AR+sD12lldXw6EdA8xy4lddaVFKpZ8b8iOp/OfwM0vu8TFs4vvKVvBv8MKn53rntn23
	F9Gllgj8BJwzqaGkWh3b/pK1KQe5KfogxAEqFh25eTEpPwWATDT6dg7AKXi2z63moVbPHDr/tOy
	MfLWCCAJsTVb0BcDzV0BmtDjuz3tkNtHm+Zope6D5JCLbBYuzJc1V+ieO4Br6I48W4ICq9WkGJ2
	75GIu6QSU34iYv7Etbj4kqDYUQZXqvFiUcYWHZ/UkARV+PRN/lbmUpXI2kYz5S6rY4TyqkUk9+P
	Uz5hjptoNwWYMK1n5Q+bZe415yYKBn6oulrLermipKanZgiaTJIb2nr5XO+4xQGhyguVMxf/dBk
	dx/7r87cMtam0SooxEPlUoypgSMCdED/JBBemdXZ+3SrqEzjI1KKdnaE3FqKbt26O8xdPUtDK4f
	laEKz972ZKL1aGUPhkEhymFbBRCUN9APubUsoRKYRH9biGmjgD1fd9UxHgIX+mzSNt
X-Received: by 2002:a05:6a00:950f:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-84fde3dcf0amr23234822b3a.15.1786947295856;
        Sun, 16 Aug 2026 23:14:55 -0700 (PDT)
Received: from 192.168.1.200 ([182.46.50.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d248b8fsm2154865b3a.44.2026.08.16.23.14.54
        for <mptcp@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2026 23:14:55 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:14:51 +0800 (CST)
From: leimingyun11@gmail.com
To: mptcp@lists.linux.dev
Message-ID: <421567758.235.1786947291466@[192.168.1.200]>
Subject: Regarding potential resource exchange collaboration for the
 Multipath TCP project
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Multipath TCP team, the Linux Kernel subsystem projects you maintain on Git=
Hub are highly professional.

 Our company focuses on the automated promotion in the technical field; we =
currently have an independent software system that can automatically identi=
fy target audiences for communication based on specific requirements. We ha=
ve envisioned a collaborative model for resource exchange, through which re=
levant links are added to the project=E2=80=99s README file in order to hel=
p the project reach more system developers or network engineers.

 I=E2=80=99m not sure whether this type of cooperative arrangement for reso=
urce exchange is suitable for further confirmation with you or for referral=
 to the relevant responsible persons
