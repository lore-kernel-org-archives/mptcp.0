Content-Type: multipart/mixed; boundary="===============3213434867991091545=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Mon, 07 Oct 2019 15:54:17 -0700
Message-ID: <alpine.OSX.2.21.1910071541250.18088@mjmartin-mac01.local>
In-Reply-To: c2c03bb1-ba2d-759f-2ad2-d8d4d74fb939@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2040

--===============3213434867991091545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Matthieu,

On Mon, 7 Oct 2019, Matthieu Baerts wrote:

> On 07/10/2019 17:23, Florian Westphal wrote:
>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> On 07/10/2019 17:00, Florian Westphal wrote:
>>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>>>> ... this turns 'tcp: clean ext on tx recycle' into a one-line change.
>>>>> =

>>>>> Good idea! Just applied this diff and added your signed-off to the =

>>>>> patch.
>>>> =

>>>> Thanks!
>>> =

>>> Just in case you want to check, here is the diff between my two branche=
s:
>> =

>> [..]
>> =

>>> If there is no objection, I am going to re-create the TopGit tree with =

>>> this
>>> new branch then!
>> =

>> Looks good, go ahead.
>
> TopGit tree re-created, export branch has been recreated, tests are still=
 OK.
>


I have one more change to suggest. In "tcp: Expose tcp struct and routine =

for MPTCP", we don't need to expose tcp_v4_init_sock() - that was probably =

associated with the pre-ULP code.

That reduces the patch to only exporting tcp_request_sock_ipv4_ops, which =

I would suggest squashing with "tcp: Export low-level TCP functions" and =

then updating the commit message:

"""
tcp: Export TCP functions and ops struct

MPTCP will make use of tcp_send_mss() and tcp_push() when sending
data to specific TCP subflows.

tcp_request_sock_ipv4_ops will be referenced during TCP subflow creation.

"""



--
Mat Martineau
Intel
--===============3213434867991091545==--
