Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFF26D4FB
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584540; cv=none; b=KXacNvocJQEdTJQ51giflsYJ+tF9JleHxMZWyuWGC+9VsMXlzqYkpU5/PWtfkKTrLyGofwBUqxzuJUI75xnrRr6IUvI2CniQJb1Lv5zbl+TbVCVL7FXx++9LfTDbR3jHj8ImQQ4W9qB1Be5Ki4ZUzXBlKFaZpW9c4QeG/Qj7NE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584540; c=relaxed/simple;
	bh=7RQwLbSJWi+hraZnI7hwuEiLO4sUtHMtDgDPdjCCSVo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CHK7Q4ekcYITsXAgIiQXLG817izySL5iYtp3tAqYoAAu+T6SW3G0FRjINL1YosOg3urSBSzg9hoYS/8OFpgtm0Myv0n2o77g5eRmCMy6bROqpHYKwLyVkDkdofrjKlQ67xEnuO+Muyug7m8wPCJg8gIH3R6VoTtuDP/PH3Fqojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=S6clkLi0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="S6clkLi0"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b7454c6b0so1259596e87.3
        for <mptcp@lists.linux.dev>; Thu, 07 Aug 2025 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754584537; x=1755189337; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RQwLbSJWi+hraZnI7hwuEiLO4sUtHMtDgDPdjCCSVo=;
        b=S6clkLi0HDbyuNz8tiOc2HZtu1kZwebnsX3ow5bxqpt6RrZUY7BmPXCBkumf1pqNwK
         Aq2knl66JubpZQlSgB3a5WIuTsLB8gSVGhn04zFf7g4l6GpIAGekqMma0SUSVZ+EfpLs
         eTIOSKhhO9zWUF6NyDj4SrkFtaWgaKTzdU/VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754584537; x=1755189337;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RQwLbSJWi+hraZnI7hwuEiLO4sUtHMtDgDPdjCCSVo=;
        b=Q8Q3vCpalQfwVq90exN+F7sEaCI90BeFmNu8lXeTQ1gS22yGY/rjC5OFiWunVaqyyz
         lUZwZxYcbV0izFJdX9WN6bcjzGwKMCN4koTq6f0BjkOoNIzpdju31oYJ3YeYNm8OsoE9
         +IySV1uYxSiQpOfcz78vwjvkluUWWbeVvr5N324Nsf8NMVtDgXziOTEJpv3SW54+LZgj
         2dz9XYB59NBW3xfvBiOzD+ALJhqTnYi8JVgDxM1ThTQ4mxwOtDX1E4VaGjqbjWHLa1J7
         EmAinHdDTrloho/+Z5aORmblShBvub0+m++4ZDZQn2vp9ZBC7a8CSsGdvY7lFWVVYPmT
         ZN4g==
X-Gm-Message-State: AOJu0YzvQ/+xXzS0Ou9JPozAGrpFfPoGYI1WTYZNZ2QYiINnA8dfAi0W
	tWCklQNkLi81lIpYDKuUq8Jis1qtdaaHd8JTevk9yiTyTX/IRRXp3E6MzDAfPLv8NxSA3rDLfua
	y6/oKYOUt08VcuXH49cC92VJEPatBXOn/tzfJUZ2kVs3CW9Ikh9SEwDk=
X-Gm-Gg: ASbGncv0NVRVZ/ta3ltDuUAXqwJDRErrOA4N4xFl/6ty9dV7MQoeEq71Rek1bu03YpY
	ceEbKloPuVhr1DGMT7Q9UsnetDbdT8V15iujdErLffiZzt+aE6L/+SsKou1yXVCqnkpmMF6jZ6Q
	m+BHBCYqZ9JjF7ojMOZJE0whqWBCNDyzwnuF+WNNH1gxE7R+tqPvuv7sevP42TmIxIm1binFahS
	HaykA==
X-Google-Smtp-Source: AGHT+IEDDx0ndUnEo6oBWBuv2oe759L/PDeTEkq+rgKpL9jkoqguMMZmAvGJnU4IfE4Of2zx+ehc3M6H3Cex3Z6AGz0=
X-Received: by 2002:a05:6512:3c88:b0:55b:838c:d900 with SMTP id
 2adb3069b0e04-55caf2f43aamr1963730e87.19.1754584536867; Thu, 07 Aug 2025
 09:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 7 Aug 2025 09:35:25 -0700
X-Gm-Features: Ac12FXzeefWy8TVjk0rA2LaRCSXFyurNoW0argSapgxuSrbn36BvXhFiTlM3k2k
Message-ID: <CADg4-L8X3_O5O67NfcE5PUeNWWDBqa1cbQ0L9L0Ti_Mn-m-7Jw@mail.gmail.com>
Subject: .b4-config in export and export-net
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hello!

Is there a reason we have the .b4-config files ? And specifically them
having the same name ?

Because, when managing different branches based off either export or
export-net it creates a conflict when merging everything together to
have a single branch with all my changes.

Would it be possible to have .b4-config files with different names for
export and export-net ?


Christoph
